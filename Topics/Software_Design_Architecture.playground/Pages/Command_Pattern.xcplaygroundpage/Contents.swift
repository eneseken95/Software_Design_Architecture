import Foundation

// MARK: - Command Pattern

protocol Command {
    func execute()
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
}

final class LightOffCommand: Command {
    private let light: Light

    init(light: Light) {
        self.light = light
    }

    func execute() {
        light.off()
    }
}

final class RemoteControl {
    private var commands: [Command] = []

    func addCommand(_ command: Command) {
        commands.append(command)
    }

    func pressButtons() {
        for command in commands {
            command.execute()
        }
    }
}

// MARK: Demo

let light = Light()

let remote = RemoteControl()
remote.addCommand(LightOnCommand(light: light))
remote.addCommand(LightOffCommand(light: light))
remote.pressButtons()
