import Foundation

// MARK: Access Control

public protocol Repository {
    associatedtype Entity
    func all() -> [Entity]
}

struct Student {
    private(set) var id: UUID
    private(set) var name: String

    init(_ name: String) {
        id = UUID()
        self.name = name
    }

    mutating func rename(_ newName: String) {
        name = newName
    }
}

fileprivate extension Student {
    var debugLine: String {
        "Student(id: \(id), name: \(name))"
    }
}

// MARK: Static vs Instance Members

final class MathUtils {
    static func max(_ a: Int, _ b: Int) -> Int {
        a > b ? a : b
    }

    static func clamp(_ value: Int, min: Int, max: Int) -> Int {
        Swift.max(min, Swift.min(value, max))
    }

    private var scale: Int

    init(scale: Int) {
        self.scale = scale
    }

    func scaled(_ value: Int) -> Int {
        value * scale
    }
}

// MARK: Association / Aggregation

final class Instructor {
    let fullName: String
    weak var course: Course?

    init(fullName: String) {
        self.fullName = fullName
    }
}

final class Course {
    let name: String
    var instructor: Instructor?

    init(name: String) {
        self.name = name
    }
}

// MARK: Composition

final class Transcript {
    final class Line {
        let courseName: String
        let grade: Double

        init(courseName: String, grade: Double) {
            self.courseName = courseName
            self.grade = grade
        }
    }

    private(set) var lines: [Line] = []

    func add(_ line: Line) {
        lines.append(line)
    }
}

// MARK: Coupling & Cohesion (Dependency Injection)

protocol EmailSender {
    func send(to: String, body: String)
}

struct ConsoleEmailSender: EmailSender {
    func send(to: String, body: String) {
        print("EMAIL to \(to): \(body)")
    }
}

final class ReportService {
    private let email: EmailSender

    init(email: EmailSender) {
        self.email = email
    }

    func sendDailyReport(to mail: String) {
        email.send(to: mail, body: "Daily Report")
    }
}

// MARK: - Demo

let course = Course(name: "Software Design")
let instructor = Instructor(fullName: "Enes Eken")
course.instructor = instructor
instructor.course = course

var enes = Student("Enes Eken")
enes.rename("Enes Efe Eken")

print(MathUtils.max(3, 5))
print(MathUtils(scale: 2).scaled(21))

let transcript = Transcript()
transcript.add(.init(courseName: "Software Design", grade: 95))
transcript.add(.init(courseName: "Design Patterns", grade: 88))

let service = ReportService(email: ConsoleEmailSender())
service.sendDailyReport(to: "enes@example.com")
