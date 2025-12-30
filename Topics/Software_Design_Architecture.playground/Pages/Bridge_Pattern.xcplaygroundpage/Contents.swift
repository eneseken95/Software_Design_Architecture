import Foundation

// MARK: - Bridge Pattern

// MARK: Shape Color Bridge

protocol Color {
    func applyColor()
}

struct RedColor: Color {
    func applyColor() {
        print("Applying Red Color")
    }
}

struct BlueColor: Color {
    func applyColor() {
        print("Applying Blue Color")
    }
}

struct GreenColor: Color {
    func applyColor() {
        print("Applying Green Color")
    }
}

class shape {
    private let color: Color

    init(color: Color) {
        self.color = color
    }

    func draw() {
        fatalError("Subclasses implement")
    }

    func applyColor() {
        color.applyColor()
    }
}

final class Circle: shape {
    override func draw() {
        print("Drawing a Circle")
        applyColor()
    }
}

final class Rectangle: shape {
    override func draw() {
        print("Drawing a Rectangle")
        applyColor()
    }
}

let redCircle = Circle(color: RedColor())
let blueRectangle = Rectangle(color: BlueColor())
let greenRectangle = Rectangle(color: GreenColor())

redCircle.draw()
blueRectangle.draw()
greenRectangle.draw()

// MARK: Remote + Device Bridge

protocol Device: AnyObject {
    var isOn: Bool { get set }
    var channel: Int { get set }

    func powerOn()
    func powerOff()
    func setChannel(_ number: Int)
}

final class TV: Device {
    var isOn: Bool = false
    var channel: Int = 1

    func powerOn() {
        isOn = true
    }

    func powerOff() {
        isOn = false
    }

    func setChannel(_ number: Int) {
        channel = number
        print("TV channel: \(channel)")
    }
}

final class Radio: Device {
    var isOn: Bool = false
    var channel: Int = 90

    func powerOn() {
        isOn = true
    }

    func powerOff() {
        isOn = false
    }

    func setChannel(_ number: Int) {
        channel = number
        print("Radio frequency: \(channel)")
    }
}

class Remote {
    fileprivate let device: Device

    init(device: Device) {
        self.device = device
    }

    func togglePower() {
        device.isOn ? device.powerOff() : device.powerOn()
    }

    func channelUp() {
        device.setChannel(device.channel + 1)
    }

    func channelDown() {
        device.setChannel(max(1, device.channel - 1))
    }
}

final class AdvancedRemote: Remote {
    func mute() {
        print("Muting...")
    }

    func setchannel(_ number: Int) {
        device.setChannel(number)
    }
}

let tv = TV()
let basicRemote = Remote(device: tv)

basicRemote.togglePower()
basicRemote.channelUp()

let radio = Radio()
let advancedRemote = AdvancedRemote(device: radio)

advancedRemote.togglePower()
advancedRemote.setchannel(101)
advancedRemote.mute()

// MARK: Payment + Subscription Bridge

protocol PaymentGateway {
    func charge(amount: Decimal, descriptiom: String) -> Bool
    func subscribe(amount: Decimal, period: String, description: String) -> Bool
}

struct StripeGateway: PaymentGateway {
    func charge(amount: Decimal, descriptiom: String) -> Bool {
        print("Charging \(amount) via Stripe...")
        return true
    }

    func subscribe(amount: Decimal, period: String, description: String) -> Bool {
        print("Subscribing \(amount) via Stripe for \(period)...")
        return true
    }
}

struct IyzicoGateway: PaymentGateway {
    func charge(amount: Decimal, descriptiom: String) -> Bool {
        print("Charging \(amount) via Iyzico...")
        return true
    }

    func subscribe(amount: Decimal, period: String, description: String) -> Bool {
        print("Subscribing \(amount) via Iyzico for \(period)...")
        return true
    }
}

class Payment {
    fileprivate let gateway: PaymentGateway

    init(gateway: PaymentGateway) {
        self.gateway = gateway
    }

    func pay(_ amount: Decimal, description: String) -> Bool {
        fatalError("Override")
    }
}

final class SinglePayment: Payment {
    override func pay(_ amount: Decimal, description: String) -> Bool {
        return gateway.charge(amount: amount, descriptiom: description)
    }
}

final class SubscriptionPayment: Payment {
    private let period: String

    init(gateway: PaymentGateway, period: String) {
        self.period = period
        super.init(gateway: gateway)
    }

    override func pay(_ amount: Decimal, description: String) -> Bool {
        return gateway.subscribe(amount: amount, period: period, description: description)
    }
}

let stripeSingle = SinglePayment(gateway: StripeGateway())
_ = stripeSingle.pay(10, description: "Test Payment")

let iyzicoSub = SubscriptionPayment(gateway: IyzicoGateway(), period: "monthly")
_ = iyzicoSub.pay(10, description: "Test Subscription")
