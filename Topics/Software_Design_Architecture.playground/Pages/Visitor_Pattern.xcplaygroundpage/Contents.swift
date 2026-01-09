import Foundation

// MARK: - Visitor Pattern

// MARK: Tax Calculation Visitor

protocol Visitor {
    func visit(_ book: Book)
    func visit(_ food: Food)
}

protocol Element {
    func accept(_ visitor: Visitor)
}

final class Book: Element {
    private let title: String
    private let price: Double

    init(title: String, price: Double) {
        self.title = title
        self.price = price
    }

    func getTitle() -> String {
        title
    }

    func getPrice() -> Double {
        price
    }

    func accept(_ visitor: Visitor) {
        visitor.visit(self)
    }
}

final class Food: Element {
    private let name: String
    private let price: Double

    init(name: String, price: Double) {
        self.name = name
        self.price = price
    }

    func getName() -> String {
        name
    }

    func getPrice() -> Double {
        price
    }

    func accept(_ visitor: Visitor) {
        visitor.visit(self)
    }
}

final class TaxVisitor: Visitor {
    func visit(_ book: Book) {
        let tax = book.getPrice() * 0.5
        print("Book tax: \(tax)")
    }

    func visit(_ food: Food) {
        let tax = food.getPrice() * 0.18
        print("Food tax: \(tax)")
    }
}

let cart: [Element] = [
    Book(title: "Design Patterns", price: 100),
    Food(name: "Pizza", price: 50),
]

let taxVisitor: Visitor = TaxVisitor()

for element in cart {
    element.accept(taxVisitor)
}
