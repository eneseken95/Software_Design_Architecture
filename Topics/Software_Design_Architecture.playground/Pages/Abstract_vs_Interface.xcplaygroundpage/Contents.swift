import Foundation

// MARK: - Protocols

protocol Payment {
    func pay(amount: Decimal) -> Bool
}

// MARK: - Protocol Extension (Default Implementation)

extension Payment {
    func pay(amount: Decimal) -> Bool {
        amount > 0
    }
}

// MARK: - Inheritance / Base Class

class BaseGateway: Payment {
    // MARK: - Abstract Method Pattern

    func pay(amount: Decimal) -> Bool {
        fatalError("override me")
    }

    func sign(_ payload: String) -> String {
        "SIGNED:\(payload)"
    }
}

// MARK: - Final Class (Prevents Further Inheritance)

final class StripeGateway: BaseGateway {
    // MARK: - Method Overriding

    override func pay(amount: Decimal) -> Bool {
        guard super.pay(amount: amount) else {
            return false
        }
        print("Stripe charged \(amount). Signature: \(sign("OK"))")
        return true
    }
}

// MARK: - Usage Example

let gateway = StripeGateway()
_ = gateway.pay(amount: 100)
