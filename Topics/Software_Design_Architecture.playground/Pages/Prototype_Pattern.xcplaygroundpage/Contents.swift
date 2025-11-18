import Foundation

// MARK: - Prototype Pattern

protocol Prototype {
    func clone() -> Self
}

final class User: Prototype {
    var name: String

    init(name: String) {
        self.name = name
    }

    func clone() -> Self {
        return Self(name: name)
    }
}

let u1 = User(name: "John")
let u2 = u1.clone()

u2.name = "Jane"

print(u1.name)
print(u2.name)

// MARK: - Shallow Copy

final class Adress {
    var city: String

    init(city: String) {
        self.city = city
    }
}

final class PersonShallow: Prototype {
    var name: String
    var address: Adress

    init(name: String, address: Adress) {
        self.name = name
        self.address = address
    }

    func clone() -> Self {
        return Self(name: name, address: address)
    }
}

let adr = Adress(city: "İstanbul")
let p1 = PersonShallow(name: "Enes", address: adr)
let p2 = p1.clone()

p2.address.city = "Ankara"

print(p1.address.city)
print(p2.address.city)

// MARK: - Deep Copy

final class PersonDeep: Prototype {
    var name: String
    var address: Adress

    init(name: String, address: Adress) {
        self.name = name
        self.address = address
    }

    func clone() -> Self {
        let copiedAddress = Adress(city: address.city)
        return Self(name: name, address: copiedAddress)
    }
}

let adr2 = Adress(city: "İstanbul")
let p3 = PersonDeep(name: "John", address: adr2)
let p4 = p1.clone()

p3.address.city = "New York"

print(p3.address)
print(p4.address)

// MARK: - Prototype Registry

protocol GameUnit {
    func clone() -> GameUnit
    func info()
}

final class Soldier: GameUnit {
    var hp: Int

    init(hp: Int) { self.hp = hp }

    func clone() -> GameUnit {
        Soldier(hp: hp)
    }

    func info() { print("Soldier hp:\(hp)") }
}

final class UnitRegistry {
    private var prototypes: [String: GameUnit] = [:]

    func register(_ key: String, proto: GameUnit) {
        prototypes[key] = proto
    }

    func create(_ key: String) -> GameUnit? {
        prototypes[key]?.clone()
    }
}

let reg = UnitRegistry()
reg.register("soldier", proto: Soldier(hp: 100))

let s1 = reg.create("soldier")
s1?.info()

// MARK: - Document/Proposal Template

protocol Document: AnyObject {
    func clone() -> Document
    func fill(_ data: [String: String])
    func render() -> String
}

final class OfferDocument: Document {
    private var template: String

    init(template: String) {
        self.template = template
    }

    func clone() -> Document {
        OfferDocument(template: template)
    }

    func fill(_ data: [String: String]) {
        for (k, v) in data {
            template = template.replacingOccurrences(of: "{{\(k)}}", with: v)
        }
    }

    func render() -> String { template }
}

let master = OfferDocument(template: "Hello {{name}}, price: {{price}} TL")

let copy = master.clone()
copy.fill(["name": "Enes", "price": "5000"])
print(copy.render())
