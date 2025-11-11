//
//  Student.swift
//
//
//  Created by Enes Eken 2 on 11.11.2025.
//

import Foundation

public struct Student {
    public let firstName: String
    public let lastName: String
    public let id: Int
    public let department: String
    public let faculty: String
    public let entryYear: Int
    public let grade: Int

    public init(firstName: String, lastName: String, id: Int, department: String, faculty: String, entryYear: Int, grade: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.id = id
        self.department = department
        self.faculty = faculty
        self.entryYear = entryYear
        self.grade = grade
    }

    public func getNameSurname() -> String {
        return firstName + " " + lastName
    }

    public func getId() -> Int {
        return id
    }

    public func getDepartment() -> String {
        return department
    }

    public func getFaculty() -> String {
        return faculty
    }

    public func getEntryYear() -> Int {
        return entryYear
    }

    public func getGrade() -> Int {
        return grade
    }
}
