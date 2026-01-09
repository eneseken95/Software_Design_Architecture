import Foundation

// MARK: - State Pattern

// MARK: Order Processing State

protocol OrderState {
    func proceed(_ context: OrderContext)
    var name: String { get }
}

final class NewState: OrderState {
    var name: String { "NEW" }

    func proceed(_ context: OrderContext) {
        print("Order is now in \(name) state.")
        context.setState(ShippedState())
    }
}

final class ShippedState: OrderState {
    var name: String { "SHIPPED" }

    func proceed(_ context: OrderContext) {
        print("Order is now in \(name) state.")
        context.setState(DeliveredState())
    }
}

final class DeliveredState: OrderState {
    var name: String { "DELIVERED" }

    func proceed(_ context: OrderContext) {
        print("Order is now in \(name) state.")
        print("Order is already delivered.")
    }
}

final class CancelledState: OrderState {
    var name: String { "CANCELLED" }

    func proceed(_ context: OrderContext) {
        print("Order is now in \(name) state.")
        print("Cancelled orders cannot proceed.")
    }
}

final class OrderContext {
    private var state: OrderState

    init(state: OrderState = NewState()) {
        self.state = state
    }

    func setState(_ state: OrderState) {
        self.state = state
    }

    func proceed() {
        state.proceed(self)
    }

    func getStateName() -> String {
        state.name
    }

    func cancel() {
        if state.name == "NEW" {
            print("Cancelling order...")
            setState(CancelledState())
        } else {
            print("Cannot cancel an order that is not in NEW state. Current: \(state.name)")
        }
    }
}

let order = OrderContext()

print(order.getStateName())
order.proceed()

print(order.getStateName())
order.proceed()

print(order.getStateName())
order.proceed()

let order2 = OrderContext()
print(order2.getStateName())
order2.cancel()
print(order2.getStateName())
order2.proceed()
