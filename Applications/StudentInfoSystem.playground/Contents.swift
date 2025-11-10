import Foundation

final class Student {
    let firstName: String
    let lastName: String
    let id: Int
    let department: String
    let faculty: String
    let entryYear: Int
    let grade: Int

    init(firstName: String, lastName: String, id: Int, department: String, faculty: String, entryYear: Int, grade: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.id = id
        self.department = department
        self.faculty = faculty
        self.entryYear = entryYear
        self.grade = grade
    }

    public func getDepartment() -> String {
        return department
    }

    public func getFaculty() -> String {
        return faculty
    }
}

let student = Student(firstName: "Enes", lastName: "Eken", id: 12345, department: "Software Engineering", faculty: "Faculty of Information Technology", entryYear: 2023, grade: 3)

print("\(student.firstName) \(student.lastName)")

print(student.getFaculty())
print(student.getDepartment())
