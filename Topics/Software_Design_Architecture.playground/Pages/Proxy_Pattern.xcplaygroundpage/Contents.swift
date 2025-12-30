import Foundation

// MARK: - Proxy Pattern

// MARK: Protection Proxy

struct User {
    let username: String
    let role: Role

    enum Role: String {
        case admin = "Admin"
        case user = "User"
    }
}

protocol ReportGenerator {
    func generateReport(_ user: User)
}

final class RealReportGenerator: ReportGenerator {
    func generateReport(_ user: User) {
        print("Generating confidential report for role: \(user.role.rawValue)")
    }
}

final class SecurityReportProxy: ReportGenerator {
    private let real: ReportGenerator

    init(_ real: ReportGenerator) {
        self.real = real
    }

    private func hasAccess(_ user: User) -> Bool {
        user.role == .admin
    }

    func generateReport(_ user: User) {
        guard hasAccess(user) else {
            print("ACCESS DENIED")
            return
        }

        print("ACCESS GRANTED")
        real.generateReport(user)
    }
}

let admin = User(username: "Enes", role: .admin)
let normalUser = User(username: "Alex", role: .user)

let report: ReportGenerator = SecurityReportProxy(RealReportGenerator())
report.generateReport(admin)
report.generateReport(normalUser)

// MARK: Caching Proxy

struct Product {
    let id: String
    let name: String
}

protocol ProductService {
    func getProduct(_ id: String) -> Product
}

final class RealProductService: ProductService {
    func getProduct(_ id: String) -> Product {
        print("Fetching product from database...")
        return Product(id: id, name: "Product \(id)")
    }
}

final class CachedProductServiceProxy: ProductService {
    private let real: ProductService
    private var cache: [String: Product] = [:]

    init(real: ProductService = RealProductService()) {
        self.real = real
    }

    func getProduct(_ id: String) -> Product {
        if let cached = cache[id] {
            print("Returning product from cache...")
            return cached
        }

        let product = real.getProduct(id)
        cache[id] = product
        return product
    }
}

let service: ProductService = CachedProductServiceProxy()
_ = service.getProduct("42")
_ = service.getProduct("42")
_ = service.getProduct("99")

// MARK: Virtual Proxy

protocol Image {
    func display()
}

final class RealImage: Image {
    private let filename: String

    init(filename: String) {
        self.filename = filename
        loadFromDisk()
    }

    private func loadFromDisk() {
        print("Loading image from disk: \(filename)")
    }

    func display() {
        print("Displaying image: \(filename)")
    }
}

final class ImageProxy: Image {
    private let filename: String
    private var real: RealImage?

    init(filename: String) {
        self.filename = filename
    }

    func display() {
        if real == nil {
            real = RealImage(filename: filename)
        }
        real?.display()
    }
}

let thumbnails: [Image] = [
    ImageProxy(filename: "a.png"),
    ImageProxy(filename: "b.png"),
    ImageProxy(filename: "c.png"),
]

thumbnails[1].display()
thumbnails[1].display()

thumbnails.forEach { $0.display() }

// MARK: Remote + Cache Proxy

protocol ExchangeRateService {
    func getRate(from: String, to: String) -> Double
}

final class RemoteExchangeRateService: ExchangeRateService {
    func getRate(from: String, to: String) -> Double {
        print("Fetching rate from remote server...")
        return Double.random(in: 10 ... 40)
    }
}

final class CachedExchangeRateProxy: ExchangeRateService {
    private let remote: ExchangeRateService
    private var cache: [String: Double] = [:]

    init(remote: ExchangeRateService = RemoteExchangeRateService()) {
        self.remote = remote
    }

    func getRate(from: String, to: String) -> Double {
        let key = "\(from)->\(to)"

        if let cached = cache[key] {
            print("Returning cached rate: \(cached)")
            return cached
        }

        let rate = remote.getRate(from: from, to: to)
        cache[key] = rate
        print("Caching rate: \(rate)")
        return rate
    }
}

let fx: ExchangeRateService = CachedExchangeRateProxy()
let r1 = fx.getRate(from: "USD", to: "EUR")
let r2 = fx.getRate(from: "USD", to: "TRY")
print("r1=\(r1), r2=\(r2)")
