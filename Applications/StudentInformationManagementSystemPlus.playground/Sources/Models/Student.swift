//
//  Student.swift
//
//
//  Created by Enes Eken 2 on 11.11.2025.
//

import Foundation

public final class Student {
    public let firstName: String
    public let lastName: String
    public let studentID: Int

    public init(firstName: String, lastName: String, studentID: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.studentID = studentID
    }

    public func getFullName() -> String {
        return "\(firstName) \(lastName)"
    }
}
