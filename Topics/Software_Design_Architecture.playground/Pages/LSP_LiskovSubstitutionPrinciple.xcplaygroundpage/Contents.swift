import Foundation

// MARK: LSP – Liskov Substitution Principle

protocol Shape {
    func area() -> Double
}

final class Rectangle: Shape {
    var width: Double
    var height: Double

    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }

    func area() -> Double {
        width * height
    }
}

final class Square: Shape {
    var side: Double

    init(side: Double) {
        self.side = side
    }

    func area() -> Double {
        side * side
    }
}

let shapes: [Shape] = [Rectangle(width: 4, height: 5), Square(side: 3)]

for s in shapes {
    print("Area:", s.area())
}
