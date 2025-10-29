import Foundation

// MARK: Class - Struct - Enum - Protocol

// MARK: Class

class Animal {
    private(set) var name: String

    init(name: String) {
        self.name = name
    }

    func speak() -> String {
        return "Animal speaking"
    }
}

// MARK: Struct

struct Position {
    var x: Double
    var y: Double
}

// MARK: Enum

enum Species {
    case dog, cat, owl
}

// MARK: Protocol

protocol Walker {
    func walk(steps: Int)
}

class Wolf: Walker {
    func walk(steps: Int) {
        print("Wolf steps: \(steps)")
    }
}

// MARK: Inheritance - Polymorphism (override)

final class Dog: Animal {
    override func speak() -> String {
        return "Woof!"
    }
}

final class Cat: Animal, Walker {
    override func speak() -> String {
        return "Meow!"
    }

    func walk(steps: Int) {
        return print("Cat steps: \(steps)")
    }
}

final class Leon: Walker {
    func walk(steps: Int) {
        return print("Leon steps: \(steps)")
    }
}

// MARK: Composition > Inheritance

protocol SoundEngine {
    func play(_ text: String)
}

struct ConsoleSoundEngine: SoundEngine {
    func play(_ text: String) {
        print(text)
    }
}

final class SpeakingPet {
    private let animal: Animal
    private let engine: SoundEngine

    init(animal: Animal, engine: SoundEngine) {
        self.animal = animal
        self.engine = engine
    }

    func perform() {
        engine.play(animal.speak())
    }
}

// MARK: Demo

let dog = Dog(name: "Rex")
let cat = Cat(name: "Luna")

print(dog.speak())
print(dog.name)

print(cat.speak())
print(cat.name)

let performer = SpeakingPet(animal: dog, engine: ConsoleSoundEngine())
performer.perform()

// MARK: - Law of Demeter

struct Owner {
    let pet: Dog
}

struct House {
    let owner: Owner
}

func badExample(house: House) {
    print(house.owner.pet.speak())
}

func houseOwnerSpeech(house: House) {
    house.owner.pet.speak()
}

func goodExample(house: House) {
    print(houseOwnerSpeech(house: house))
}
