import Foundation

// MARK: - Professors

let professor1 = Professor(fullName: "Dr. John Miller", title: "Lecturer")
let professor2 = Professor(fullName: "Emily Davis", title: "Lecturer")

// MARK: - Students

let student1 = Student(
    firstName: "Alex",
    lastName: "Smith",
    id: 1,
    department: "Software Engineering",
    faculty: "Faculty of Technology",
    entryYear: 2024,
    grade: 1)
let student2 = Student(
    firstName: "Sophia",
    lastName: "Johnson",
    id: 2,
    department: "Software Engineering",
    faculty: "Faculty of Technology",
    entryYear: 2024,
    grade: 1)
let student3 = Student(
    firstName: "Michael",
    lastName: "Brown",
    id: 3,
    department: "Software Engineering",
    faculty: "Faculty of Technology",
    entryYear: 2024,
    grade: 1)

// MARK: - Courses

let mathematics = BasicCourse(
    name: "Mathematics",
    code: "MATH101",
    semester: "Fall",
    isElective: false,
    professor: professor1,
    credit: 2
)

let softwareLab = PracticalCourse(
    name: "Software Laboratory",
    code: "SWL301",
    semester: "Fall",
    isElective: false,
    professor: professor2,
    credit: 3
)

let internship = InternshipCourse(
    name: "Internship",
    code: "INT401",
    semester: "Spring",
    isElective: false,
    professor: professor2,
    credit: 5
)

// MARK: - Enrollment

mathematics.enroll(student1)
mathematics.enroll(student2)
softwareLab.enroll(student1)
softwareLab.enroll(student2)
internship.enroll(student3)

// MARK: - Enrollment Check

print(mathematics.isStudentEnrolled(1))
print(softwareLab.isStudentEnrolled(4))
print(internship.isStudentEnrolled(3))

// MARK: - Display

mathematics.printStudentList()
softwareLab.printStudentList()
internship.printStudentList()

// MARK: - Grade Calculation

print("Mathematics Final Grade:", mathematics.calculateGrade(80, 90, 70))
print("Software Laboratory Final Grade:", softwareLab.calculateGrade(75, 60))
print("Internship Final Grade:", internship.calculateGrade(85))
