import Foundation

// MARK: - Strategy Pattern

// MARK: Payment Strategy

protocol PaymentStrategy {
    func pay(amount: Double)
}

struct CreditCard: PaymentStrategy {
    func pay(amount: Double) {
        print("Paid \(amount) with Credit Card")
    }
}

struct PayPal: PaymentStrategy {
    func pay(amount: Double) {
        print("Paid \(amount) with PayPal")
    }
}

final class Checkout {
    private var strategy: PaymentStrategy

    init(strategy: PaymentStrategy) {
        self.strategy = strategy
    }

    func setStrategy(_ newStrategy: PaymentStrategy) {
        strategy = newStrategy
    }

    func completePurchase(amount: Double) {
        strategy.pay(amount: amount)
    }
}

let checkout = Checkout(strategy: CreditCard())
checkout.completePurchase(amount: 120.0)

checkout.setStrategy(PayPal())
checkout.completePurchase(amount: 49.0)

print(checkout)

final class CreditCardPayment: PaymentStrategy {
    private let cardNumber: String
    private let ownerName: String

    init(_ cardNumber: String, _ ownerName: String) {
        self.cardNumber = cardNumber
        self.ownerName = ownerName
    }

    func pay(amount: Double) {
        print("Paid \(amount) with Credit Card (\(cardNumber), \(ownerName))")
    }
}

final class BankTransferPayment: PaymentStrategy {
    private let iban: String

    init(iban: String) {
        self.iban = iban
    }

    func pay(amount: Double) {
        print("Paid \(amount) with Bank Transfer (\(iban))")
    }
}

final class CashPayment: PaymentStrategy {
    func pay(amount: Double) {
        print("Paid \(amount) with Cash")
    }
}

final class ShoppingCart {
    private var items: [Double] = []
    private var paymentStrategy: PaymentStrategy?

    func addItem(_ price: Double) {
        items.append(price)
    }

    func setPaymentStrategy(_ strategy: PaymentStrategy) {
        paymentStrategy = strategy
    }

    func checkout() {
        let total = items.reduce(0, +)
        guard let strategy = paymentStrategy else {
            print("No payment strategy set.")
            return
        }
        strategy.pay(amount: total)
    }
}

let cart = ShoppingCart()
cart.addItem(100)
cart.addItem(50)

let cc = CreditCardPayment("1234-5678-9012-3456", "Enes Eken")
cart.setPaymentStrategy(cc)
cart.checkout()

cart.setPaymentStrategy(BankTransferPayment(iban: "TR00 0000 0000 0000"))
cart.checkout()

// MARK: Search and Ranking Service Strategy

struct SearchResult: CustomStringConvertible {
    let id: String
    let price: Double
    let popularity: Int
    let userRating: Double

    var description: String {
        "SearchResult(id: \(id), price: \(price), popularity: \(popularity), rating: \(userRating))"
    }
}

protocol ScoringStrategy {
    func score(_ result: SearchResult) -> Double
}

final class CheapestFirstScoring: ScoringStrategy {
    func score(_ result: SearchResult) -> Double {
        return -result.price
    }
}

final class PopularityScoring: ScoringStrategy {
    func score(_ result: SearchResult) -> Double {
        return Double(result.popularity)
    }
}

final class HybridScoring: ScoringStrategy {
    func score(_ result: SearchResult) -> Double {
        let popularityWeight = 0.4
        let ratingWeight = 0.6
        let priceWeight = 1.0

        let normalizedPrice = 1.0 / (1.0 + result.price)

        let ratingScaledTo100 = (result.userRating / 0.5) * 100.0

        return popularityWeight * Double(result.popularity) + ratingWeight * ratingScaledTo100 + priceWeight * normalizedPrice
    }
}

final class SearchService {
    private var scoringStrategy: ScoringStrategy

    init(scoringStrategy: ScoringStrategy) {
        self.scoringStrategy = scoringStrategy
    }

    func setScoringStrategy(_ strategy: ScoringStrategy) {
        scoringStrategy = strategy
    }

    func sortResults(_ result: [SearchResult]) -> [SearchResult] {
        result.sorted { a, b in
            scoringStrategy.score(a) > scoringStrategy.score(b)
        }
    }
}

final class SearchServiceWithClosure {
    typealias Scorer = (SearchResult) -> Double
    private var scorer: Scorer

    init(scorer: @escaping Scorer) {
        self.scorer = scorer
    }

    func setScorer(_ scorer: @escaping Scorer) {
        self.scorer = scorer
    }

    func sortResults(_ result: [SearchResult]) -> [SearchResult] {
        result.sorted {
            scorer($0) > scorer($1)
        }
    }
}

let results: [SearchResult] = [
    .init(id: "A", price: 100, popularity: 80, userRating: 4.5),
    .init(id: "B", price: 50, popularity: 60, userRating: 4.0),
    .init(id: "C", price: 70, popularity: 95, userRating: 3.8),
]

let service = SearchService(scoringStrategy: HybridScoring())
print("Hybrid scoring:")
service.sortResults(results).forEach { print($0) }

service.setScoringStrategy(CheapestFirstScoring())
print("\nCheapest first scoring:")
service.sortResults(results).forEach { print($0) }

let service2 = SearchServiceWithClosure { result in
    -result.price
}

print("\nCheapest first scoring (closure):")
service2.sortResults(results).forEach { print($0) }

service2.setScorer { result in
    Double(result.popularity)
}

print("\nPopularity scoring (closure):")
service2.sortResults(results).forEach { print($0) }

// MARK: Compression Strategy

enum CompressionError: Error {
    case failed(String)
}

protocol CompressionStrategy {
    func compress(sourceFolder: String, targetFile: String) throws
}

final class ZipCompression: CompressionStrategy {
    func compress(sourceFolder: String, targetFile: String) throws {
        print("ZIP compress: \(sourceFolder) -> \(targetFile).zip")
    }
}

final class TarCompression: CompressionStrategy {
    func compress(sourceFolder: String, targetFile: String) throws {
        print("TAR compress: \(sourceFolder) -> \(targetFile).tar")
    }
}

final class SevenZCompression: CompressionStrategy {
    func compress(sourceFolder: String, targetFile: String) throws {
        print("7z compress: \(sourceFolder) -> \(targetFile).7z")
    }
}

final class BackupService {
    private var strategy: CompressionStrategy

    init(strategy: CompressionStrategy) {
        self.strategy = strategy
    }

    func setStrayetgy(_ strategy: CompressionStrategy) {
        self.strategy = strategy
    }

    func backup(sourceFolder: String, targetFile: String) {
        do {
            try strategy.compress(sourceFolder: sourceFolder, targetFile: targetFile)
        } catch {
            print("Compression failed: \(error)")
        }
    }
}
