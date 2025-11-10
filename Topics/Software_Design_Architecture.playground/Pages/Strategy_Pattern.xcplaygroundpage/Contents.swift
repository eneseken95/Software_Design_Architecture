import Foundation

// MARK: - Strategy Pattern

protocol PaymentStrategy {
    func pay(amount: Double)
}

struct CreditCardPayment: PaymentStrategy {
    func pay(amount: Double) {
        print("Paid \(amount) with Credit Card")
    }
}

struct PayPalPayment: PaymentStrategy {
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

// MARK: Demo

let checkout = Checkout(strategy: CreditCardPayment())
checkout.completePurchase(amount: 120.0)

checkout.setStrategy(PayPalPayment())
checkout.completePurchase(amount: 49.0)

print(checkout)
