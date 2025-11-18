import Foundation

// MARK: - Builder Pattern

class Pizza {
    let dough: String
    let hasCheese: Bool
    let hasOlive: Bool

    private init(builder: Builder) {
        dough = builder.dough
        hasCheese = builder.hasCheese
        hasOlive = builder.hasOlive
    }

    // MARK: - Nested Builder

    class Builder {
        var dough: String
        var hasCheese: Bool = false
        var hasOlive: Bool = false

        init(dough: String) {
            self.dough = dough
        }

        func addCheese(_ value: Bool) -> Builder {
            hasCheese = value
            return self
        }

        func addOlive(_ value: Bool) -> Builder {
            hasOlive = value
            return self
        }

        func build() -> Pizza {
            return Pizza(builder: self)
        }
    }
}

// MARK: - Client Usage

let myPizza = Pizza.Builder(dough: "Thin Crust")
    .addCheese(true)
    .addOlive(true)
    .build()

print("Order: \(myPizza.dough), Cheese: \(myPizza.hasCheese)")



class House {
    var walls = 0
    var doors = 0
    var roofType = ""

    func description() -> String {
        return "Walls: \(walls), Doors: \(doors), Roof: \(roofType)"
    }
}

protocol HouseeBuilder {
    func reset()
    func buildWalls(count: Int)
    func buildDoors(count: Int)
    func buildRoof(type: String)
    func getResult() -> House
}

class WoodenHouseBuilder: HouseeBuilder {
    private var house: House = House()

    func reset() {
        house = House()
    }

    func buildWalls(count: Int) {
        house.walls = count
    }

    func buildDoors(count: Int) {
        house.doors = count
    }

    func buildRoof(type: String) { house.roofType = "Wood-\(type)" }

    func getResult() -> House { return house }
}

class StoneHouseBuilder: HouseeBuilder {
    private var house: House = House()

    func reset() {
        house = House()
    }

    func buildWalls(count: Int) {
        house.walls = count
    }

    func buildDoors(count: Int) {
        house.doors = count
    }

    func buildRoof(type: String) { house.roofType = "Stone-\(type)" }

    func getResult() -> House { return house }
}

class Director {
    func constructBasic(builder: HouseeBuilder) -> House {
        builder.reset()
        builder.buildWalls(count: 10)
        builder.buildDoors(count: 2)
        builder.buildRoof(type: "Flat")
        return builder.getResult()
    }

    func constructLuxury(builder: HouseeBuilder) -> House {
        builder.reset()
        builder.buildWalls(count: 20)
        builder.buildDoors(count: 4)
        builder.buildRoof(type: "Gabled")
        return builder.getResult()
    }
}

let director = Director()

let woodenBuilder = WoodenHouseBuilder()
director.constructBasic(builder: woodenBuilder)
let myWoodenHouse = woodenBuilder.getResult()
print(myWoodenHouse.description())

let stoneBuilder = StoneHouseBuilder()
director.constructLuxury(builder: stoneBuilder)
let myStoneHouse = stoneBuilder.getResult()
print(myStoneHouse.description())
