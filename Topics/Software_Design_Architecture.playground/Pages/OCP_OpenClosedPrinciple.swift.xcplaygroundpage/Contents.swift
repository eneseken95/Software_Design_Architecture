import Foundation

// MARK: OCP - Open Closed Principle

protocol PaymentStrategy {
    func pay(amount: Double)
}

final class CreditCardPayment: PaymentStrategy {
    func pay(amount: Double) {
        print("Paid \(amount) Using Credit Card")
    }
}

final class PayPalPayment: PaymentStrategy {
    func pay(amount: Double) {
        print("Paid \(amount) Using PayPal")
    }
}

final class PaymentProcessor {
    let strategy: PaymentStrategy

    init(strategy: PaymentStrategy) {
        self.strategy = strategy
    }

    func process(amount: Double) {
        strategy.pay(amount: amount)
    }
}

let processor = PaymentProcessor(strategy: CreditCardPayment())

print(processor.strategy)
print(processor.strategy.pay(amount: 150.0))
