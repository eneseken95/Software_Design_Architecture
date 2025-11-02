import Foundation

// MARK: - Nested Enum (Enumeration)

struct Grade {
    enum Letter: String {
        case AA, BA, CB, CC
    }

    let courseId: UUID
    let value: Letter
}

// MARK: - Data Model (Value Type)

struct CourseModel {
    let id: UUID
    let name: String
    let credit: Int
}

// MARK: - Reference Type (OOP - Class)

final class StudentModel {
    let id: UUID
    private(set) var fullName: String
    private(set) var grades: [Grade] = []

    init(fullName: String) {
        id = UUID()
        self.fullName = fullName
    }

    // MARK: - Behavior (Encapsulation)

    func enrollAndGrade(course: CourseModel, letter: Grade.Letter) {
        grades.append(.init(courseId: course.id, value: letter))
    }

    func gpa(with catalog: [UUID: CourseModel]) -> Double {
        func points(_ l: Grade.Letter) -> Double {
            switch l {
            case .AA: return 4.0
            case .BA: return 3.5
            case .CB: return 3.0
            case .CC: return 2.5
            }
        }

        var totalCredits = 0
        var totalPoints = 0.0

        for g in grades {
            guard let course = catalog[g.courseId] else {
                continue
            }
            totalCredits += course.credit
            totalPoints += points(g.value) * Double(course.credit)
        }

        return totalCredits == 0 ? 0.0 : totalPoints / Double(totalCredits)
    }
}

// MARK: - Instance Creation and Usage (OOP Example)

let oop = CourseModel(id: UUID(), name: "Clean Architecture", credit: 4)
let dp = CourseModel(id: UUID(), name: "Design Pattern", credit: 3)
let catalog = [oop.id: oop, dp.id: dp]

let student = StudentModel(fullName: "Enes Eken")
student.enrollAndGrade(course: oop, letter: .AA)
student.enrollAndGrade(course: dp, letter: .BA)

print("GPA:", student.gpa(with: catalog))
