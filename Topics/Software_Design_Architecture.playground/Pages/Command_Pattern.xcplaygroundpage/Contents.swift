import Foundation

// MARK: - Command Pattern

protocol Command {
    func execute()
    func undo()
}

final class Light {
    func on() {
        print("Light ON")
    }

    func off() {
        print("Light OFF")
    }
}

final class LightOnCommand: Command {
    private let light: Light

    init(light: Light) {
        self.light = light
    }

    func execute() {
        light.on()
    }

    func undo() {
        light.off()
    }
}

final class LightOffCommand: Command {
    private let light: Light

    init(light: Light) {
        self.light = light
    }

    func execute() {
        light.off()
    }

    func undo() {
        light.on()
    }
}

final class RemoteControl {
    private var commands: [Command] = []
    private var history: [Command] = []

    func addCommand(_ command: Command) {
        commands.append(command)
    }

    func pressButtons() {
        for command in commands {
            command.execute()
            history.append(command)
        }
    }

    func undoLast() {
        guard let last = history.popLast() else { return }
        last.undo()
    }
}

// MARK: Demo

let light = Light()

let remote = RemoteControl()
remote.addCommand(LightOnCommand(light: light))
remote.addCommand(LightOffCommand(light: light))
remote.pressButtons()

remote.undoLast()
