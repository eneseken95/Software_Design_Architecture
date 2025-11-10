import Foundation

// MARK: - Overloading vs Overriding

// MARK: - Overloading

func greet(_ name: String) {
    print("Hello, \(name)")
}

func greet(_ count: Int) {
    print("Hello, \(count)")
}

func greet(_ first: String, _ last: String) {
    print("Hello, \(first) \(last)")
}

greet("Enes")
greet(3)
greet("Enes", "Eken")

// MARK: - Overriding

class Animal {
    func speak() {
        print("...")
    }
}

class Dog: Animal {
    override func speak() {
        print("Woof!")
    }
}

let a = Dog()
print(a.speak())
