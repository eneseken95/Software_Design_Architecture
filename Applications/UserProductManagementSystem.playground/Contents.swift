import Foundation

// MARK: - Product (Base Class)

class Product {
    private var name: String
    private var price: Double
    private var owner: User

    init(name: String, price: Double, owner: User) {
        self.name = name
        self.price = price
        self.owner = owner
    }

    func getName() -> String {
        return name
    }
}

// MARK: - User

class User {
    private var name: String
    private var email: String
    private var password: String

    init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
    }

    func getEmail() -> String {
        return email
    }

    func viewProduct(_ product: Product) {
        print("\(getEmail()) viewed the product \(product.getName()).")
    }
}

// MARK: - Product Subclasses

final class Car: Product {
    private var brand: String

    init(name: String, price: Double, owner: User, brand: String) {
        self.brand = brand
        super.init(name: name, price: price, owner: owner)
    }

    override func getName() -> String {
        return "Car: \(super.getName())"
    }
}

final class Land: Product {
    private var area: Double

    init(name: String, price: Double, owner: User, area: Double) {
        self.area = area
        super.init(name: name, price: price, owner: owner)
    }

    override func getName() -> String {
        return "Land: \(super.getName())"
    }
}

final class Apartment: Product {
    private var roomCount: Int

    init(name: String, price: Double, owner: User, roomCount: Int) {
        self.roomCount = roomCount
        super.init(name: name, price: price, owner: owner)
    }

    override func getName() -> String {
        return "Apartment: \(super.getName())"
    }
}

// MARK: - Database (Singleton)

@MainActor
final class Database {
    static let shared = Database()

    private init() { }

    private var products: [Product] = []
    private var users: [User] = []

    func addProduct(_ product: Product) {
        products.append(product)
    }

    func addUser(_ user: User) {
        users.append(user)
    }

    func findUser(byEmail email: String) -> User? {
        return users.first { $0.getEmail() == email }
    }
}

// MARK: - Example Usage

let db = Database.shared

let user1 = User(name: "Alex", email: "alex@mail.com", password: "1234")
db.addUser(user1)

let car = Car(name: "BMW M3", price: 1500000, owner: user1, brand: "BMW")
db.addProduct(car)

user1.viewProduct(car)
