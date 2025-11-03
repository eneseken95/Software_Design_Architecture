import Foundation

// MARK: - Observer Pattern

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

// MARK: - Demo

let agency = NewsAgency()
let enes = Subscriber(name: "enes")
let efe = Subscriber(name: "efe")

agency.attach(enes)
agency.attach(efe)
agency.notify("New iOS 26 Released!")

print(agency.observers)
