import Foundation

// MARK: - Immutability (Değişmezlik)

let pi = 3.14

var counter = 0
counter += 1

struct Point {
    var x: Int
    var y: Int
}

var p1 = Point(x: 1, y: 2)
var p2 = p1
p2.x = 10

print(pi)
print(counter)
print(p1)
print(p2)

final class Box {
    var value: Int

    init(value: Int) {
        self.value = value
    }

    func valueState() {
        value = 5
    }
}

let b1 = Box(value: 1)
let b2 = b1

print(b1.value)
print(b2.value)

b2.value = 10

print(b1.value)
print(b2.value)

struct Counter {
    private(set) var value = 0

    mutating func inc() {
        value += 1
    }
}

var c = Counter()
c.inc()

print("counter:", c.value)

func sum(_ a: Int, _ b: Int) -> Int {
    return a + b
}

print("sum:", sum(2, 3))
