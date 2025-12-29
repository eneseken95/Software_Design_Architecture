import Foundation

// MARK: - Composite Pattern

// MARK: File System Composite

protocol FileSystemItem {
    func printTree(indent: String)
}

final class FileItem: FileSystemItem {
    private let name: String

    init(name: String) {
        self.name = name
    }

    func printTree(indent: String) {
        print("\(indent)- \(name)")
    }
}

final class Directory: FileSystemItem {
    private let name: String
    private var children: [FileSystemItem] = []

    init(name: String) {
        self.name = name
    }

    func add(_ item: FileSystemItem) {
        children.append(item)
    }

    func removeAll() {
        children.removeAll()
    }

    func printTree(indent: String) {
        print("\(indent)+ \(name)")
        for child in children {
            child.printTree(indent: indent + " ")
        }
    }
}

let root = Directory(name: "root")

let src = Directory(name: "src")
let images = Directory(name: "images")

root.add(src)
root.add(images)

src.add(FileItem(name: "app.swift"))
images.add(FileItem(name: "logo.png"))

root.printTree(indent: "")

// MARK: Menu Composite

protocol MenuComponent {
    func printMenu(indent: String)
}

final class MenuItem: MenuComponent {
    private let name: String

    init(name: String) {
        self.name = name
    }

    func printMenu(indent: String) {
        print("\(indent)- \(name)")
    }
}

final class Menu: MenuComponent {
    private let name: String
    private var items: [MenuComponent] = []

    init(name: String) {
        self.name = name
    }

    func add(_ component: MenuComponent) {
        items.append(component)
    }

    func printMenu(indent: String) {
        print("\(indent)\(name):")
        items.forEach { $0.printMenu(indent: indent + " ") }
    }
}

let mainMenu = Menu(name: "Main Menu")
mainMenu.add(MenuItem(name: "Settings"))
mainMenu.add(MenuItem(name: "Profile"))

let help = Menu(name: "Help")
help.add(MenuItem(name: "FAQ"))
help.add(MenuItem(name: "Contact"))

mainMenu.add(help)

mainMenu.printMenu(indent: "")

// MARK: Organization Chart Composite

protocol Employee {
    func getSalary() -> Double
    func printInfo(indent: String)
}

final class SimpleEmployee: Employee {
    private let name: String
    private let salary: Double

    init(name: String, salary: Double) {
        self.name = name
        self.salary = salary
    }

    func getSalary() -> Double {
        return salary
    }

    func printInfo(indent: String) {
        print("\(indent)- \(name): \(salary)")
    }
}

final class Manager: Employee {
    private let name: String
    private let salary: Double
    private var team: [Employee] = []

    init(name: String, salary: Double) {
        self.name = name
        self.salary = salary
    }

    func add(_ e: Employee) {
        team.append(e)
    }

    func getSalary() -> Double {
        var total = salary
        for e in team {
            total += e.getSalary()
        }
        return total
    }

    func printInfo(indent: String) {
        print("\(indent)[Manager] \(name) (self: \(salary), total: \(getSalary()))")
        team.forEach {
            $0.printInfo(indent: "\(indent)" + " ")
        }
    }
}

let dev1 = SimpleEmployee(name: "Tom", salary: 50000)
let dev2 = SimpleEmployee(name: "Enes", salary: 55000)

let lead = Manager(name: "Alex", salary: 80000)

lead.add(dev1)
lead.add(dev2)

lead.printInfo(indent: "")

// MARK: UI Components Composite

protocol UIComponent {
    func draw()
}

final class Button: UIComponent {
    private let text: String
    init(text: String) {
        self.text = text
    }

    func draw() {
        print("Drawing Button: \(text)")
    }
}

final class Panel: UIComponent {
    private var children: [UIComponent] = []

    func add(_ component: UIComponent) {
        children.append(component)
    }

    func draw() {
        print("Drawing Panel")
        for c in children {
            c.draw()
        }
    }
}

let panel = Panel()
panel.add(Button(text: "OK"))
panel.add(Button(text: "Cancel"))

let nested = Panel()
nested.add(Button(text: "Help"))
panel.add(nested)

panel.draw()
