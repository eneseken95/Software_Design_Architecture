import Foundation

// MARK: - Product Protocols

protocol Button {
    func render()
}

protocol Dialog {
    func show()
}

// MARK: - Concrete Products

final class MacButton: Button {
    func render() {
        print("Rendering a Mac button.")
    }
}

final class WinButton: Button {
    func render() {
        print("Rendering a Win button.")
    }
}

final class MacDialog: Dialog {
    func show() {
        print("Showing a Mac dialog.")
    }
}

final class WinDialog: Dialog {
    func show() {
        print("Showing a Win dialog.")
    }
}

// MARK: - Abstract Factory

protocol GUIFactory {
    func createButton() -> Button
    func createDialog() -> Dialog
}

// MARK: - Concrete Factories

final class MacFactory: GUIFactory {
    func createDialog() -> any Dialog {
        return MacDialog()
    }

    func createButton() -> Button {
        return MacButton()
    }
}

final class WinFactory: GUIFactory {
    func createDialog() -> any Dialog {
        return WinDialog()
    }

    func createButton() -> Button {
        return WinButton()
    }
}

// MARK: - Client

final class Application {
    private let factory: GUIFactory

    init(factory: GUIFactory) {
        self.factory = factory
    }

    func run() {
        let button = factory.createButton()
        let dialog = factory.createDialog()

        button.render()
        dialog.show()
    }
}

// MARK: - Runtime Selection

let currentOS = "macOS"

let factory: GUIFactory = (currentOS == "macOS") ? MacFactory() : WinFactory()
let app = Application(factory: factory)
app.run()
