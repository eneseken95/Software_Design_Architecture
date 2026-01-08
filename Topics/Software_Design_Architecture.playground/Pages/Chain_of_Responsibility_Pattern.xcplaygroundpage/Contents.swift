import Foundation

// MARK: - Chain of Responsibility Pattern

// MARK: Support Handler Chain of Responsibility

enum Priority {
    case low
    case medium
    case high
}

struct SupportRequest {
    let message: String
    let priority: Priority
}

class SupportHandler {
    private let next: SupportHandler?

    init(next: SupportHandler?) {
        self.next = next
    }

    final func handle(_ request: SupportRequest) {
        if canHandle(request) {
            Progress(request)
        } else if let next {
            next.handle(request)
        } else {
            print(#function, "Cannot handle \(request)")
        }
    }

    func canHandle(_ request: SupportRequest) -> Bool {
        fatalError("Subclasses must override canHandle(_:)")
    }

    func Progress(_ request: SupportRequest) {
        fatalError("Subclasses must override Progress(_:)")
    }
}

final class JuniorSupportHandler: SupportHandler {
    override func canHandle(_ request: SupportRequest) -> Bool {
        request.priority == .low
    }

    override func Progress(_ request: SupportRequest) {
        print("JuniorSupportHandler is processing \(request.message)")
    }
}

final class SeniorSupportHandler: SupportHandler {
    override func canHandle(_ request: SupportRequest) -> Bool {
        request.priority == .medium
    }

    override func Progress(_ request: SupportRequest) {
        print("SeniorSupportHandler is processing \(request.message)")
    }
}

final class ManagerSupportHandler: SupportHandler {
    override func canHandle(_ request: SupportRequest) -> Bool {
        request.priority == .high
    }

    override func Progress(_ request: SupportRequest) {
        print("ManagerSupportHandler is processing \(request.message)")
    }
}

let chain: SupportHandler = JuniorSupportHandler(next: SeniorSupportHandler(next: ManagerSupportHandler(next: nil)))

let request1 = SupportRequest(message: "I need help with my computer", priority: .low)

let request2 = SupportRequest(message: "I need help with my printer", priority: .medium)

let request3 = SupportRequest(message: "I need help with my server", priority: .high)

chain.handle(request1)
chain.handle(request2)
chain.handle(request3)
