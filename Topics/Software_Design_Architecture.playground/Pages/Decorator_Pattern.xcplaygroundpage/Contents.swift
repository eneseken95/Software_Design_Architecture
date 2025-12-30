import Foundation

// MARK: - Decorator Pattern

// MARK: Notifier Decorator

protocol Notifier {
    func send(_ message: String)
}

final class EmailNotifier: Notifier {
    func send(_ message: String) {
        print("Email: \(message)")
    }
}

class NotifierDecorator: Notifier {
    private let wrappee: Notifier

    init(_ wrappee: Notifier) {
        self.wrappee = wrappee
    }

    func send(_ message: String) {
        wrappee.send(message)
    }
}

final class SMSNotifier: NotifierDecorator {
    override func send(_ message: String) {
        super.send(message)
        print("SMS: \(message)")
    }
}

final class SlackNotifier: NotifierDecorator {
    override func send(_ message: String) {
        super.send(message)
        print("Slack: \(message)")
    }
}

let notifier: Notifier = SlackNotifier(SMSNotifier(EmailNotifier()))

notifier.send("Server down!")

// MARK: DB Repository Decorator

protocol UserRepository {
    func save(user: String)
    func findById(_ id: String) -> String
}

final class DDbUserRepository: UserRepository {
    func save(user: String) {
        print("DB: saving \(user)")
    }

    func findById(_ id: String) -> String {
        return "User \(id)"
    }
}

final class LoggingUserRepository: UserRepository {
    private let wrappee: UserRepository

    init(_ wrappee: UserRepository) {
        self.wrappee = wrappee
    }

    func save(user: String) {
        wrappee.save(user: user)
    }

    func findById(_ id: String) -> String {
        wrappee.findById(id)
    }
}

let plainRepo: UserRepository = DDbUserRepository()
plainRepo.save(user: "Enes")

let loggedRepo: UserRepository = LoggingUserRepository(DDbUserRepository())
loggedRepo.save(user: "Enes")

print(loggedRepo.findById("123"))
