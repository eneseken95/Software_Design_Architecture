import Foundation

// MARK: - Observer Pattern

// MARK: Agency Notification Observer

protocol Observer: AnyObject {
    func update(_ message: String)
}

protocol Subject {
    func attach(_ observer: Observer)
    func detach(_ observer: Observer)
    func notify(_ message: String)
}

final class NewsAgency: Subject {
    var observers: [Observer] = []

    func attach(_ observer: Observer) {
        observers.append(observer)
    }

    func detach(_ observer: Observer) {
        observers.removeAll { $0 === observer }
    }

    func notify(_ message: String) {
        for observer in observers {
            observer.update(message)
        }
    }
}

final class Subscriber: Observer {
    private let name: String

    init(name: String) {
        self.name = name
    }

    func update(_ message: String) {
        print("\(name) received news: \(message)")
    }
}

let agency = NewsAgency()
let enes = Subscriber(name: "enes")
let efe = Subscriber(name: "efe")

agency.attach(enes)
agency.attach(efe)
agency.notify("New iOS 26 Released!")

print(agency.observers)

// MARK: Stock Tracking Observer

protocol StockObserver: AnyObject {
    func update(_ newPrice: Double)
}

protocol StockSubject {
    func registerObserver(_ o: StockObserver)
    func removeObserver(_ o: StockObserver)
    func notifyObservers()
}

final class Stock: StockSubject {
    private var observers: [StockObserver] = []
    private let name: String
    private var price: Double

    init(_ name: String, _ price: Double) {
        self.name = name
        self.price = price
    }

    func registerObserver(_ o: StockObserver) {
        observers.append(o)
    }

    func removeObserver(_ o: StockObserver) {
        observers.removeAll { $0 === o }
    }

    func setPrice(_ price: Double) {
        self.price = price
        notifyObservers()
    }

    func notifyObservers() {
        for o in observers {
            o.update(price)
        }
    }
}

final class MobileClient: StockObserver {
    private let username: String

    init(username: String) {
        self.username = username
    }

    func update(_ newPrice: Double) {
        print("\(username) updated stock price to \(newPrice)")
    }
}

final class WebClient: StockObserver {
    private let dashboardName: String

    init(dashboardName: String) {
        self.dashboardName = dashboardName
    }

    func update(_ newPrice: Double) {
        print("\(dashboardName) updated stock price to \(newPrice)")
    }
}

let btc = Stock("BTC", 65.000)

let mobile: StockObserver = MobileClient(username: "Enes")
let web: StockObserver = WebClient(dashboardName: "Enes' Dashboard")

btc.registerObserver(mobile)
btc.registerObserver(web)

btc.setPrice(100)
btc.setPrice(90)

btc.removeObserver(mobile)
btc.removeObserver(web)
