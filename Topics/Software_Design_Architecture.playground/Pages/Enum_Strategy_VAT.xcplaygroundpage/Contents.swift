import Foundation

// MARK: - Enum-based Strategy (VAT/VAT calculation)

enum VATStrategy {
    case zero
    case reduced(Double)
    case standard
    case custom(Double)

    func apply(to netPrice: Decimal) -> Decimal {
        let rate: Decimal

        switch self {
        case .zero:
            rate = 0
        case let .reduced(r):
            rate = Decimal(r)
        case .standard:
            rate = 0.20
        case let .custom(r):
            rate = Decimal(r)
        }
        return netPrice * (1 + rate)
    }
}

// MARK: Demo

let net: Decimal = 100

let p0 = VATStrategy.zero.apply(to: net)
let p1 = VATStrategy.reduced(0.08).apply(to: net)
let p2 = VATStrategy.standard.apply(to: net)
let p3 = VATStrategy.custom(0.25).apply(to: net)

print("Zero(0%):", p0)
print("Reduced(8%):", p1)
print("Standard(20%):", p2)
print("Custom(25%):", p3)
