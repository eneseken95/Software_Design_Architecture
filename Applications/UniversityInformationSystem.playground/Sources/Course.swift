//
//  Course.swift
//
//
//  Created by Enes Eken 2 on 11.11.2025.
//

import Foundation

public class Course {
    public let name: String
    public let code: String
    public let semester: String
    public let isElective: Bool
    public let professor: Professor
    public let credit: Int
    public var students: [Student] = []

    public init(name: String, code: String, semester: String, isElective: Bool, professor: Professor, credit: Int) {
        self.name = name
        self.code = code
        self.semester = semester
        self.isElective = isElective
        self.professor = professor
        self.credit = credit
    }

    public func calculateGrade(_ scores: Double...) -> String {
        fatalError("Subclasses must override calculateGrade(_:) method.")
    }

    public func enroll(_ student: Student) {
        students.append(student)
    }

    public func isStudentEnrolled(_ id: Int) -> Bool {
        return students.contains {
            $0.id == id
        }
    }

    public func printStudentList() {
        print("\(name) Student List:")
        students.forEach {
            print("- \($0.getNameSurname())")
        }
    }

    public func letterGrade(_ average: Double) -> String {
        switch average {
        case 90 ... 100:
            return "A"
        case 80 ..< 90:
            return "B"
        case 70 ..< 80:
            return "C"
        case 60 ..< 70:
            return "D"
        default:
            return "F"
        }
    }
}
