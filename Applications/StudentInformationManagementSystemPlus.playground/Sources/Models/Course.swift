//
//  Course.swift
//  
//
//  Created by Enes Eken 2 on 11.11.2025.
//

import Foundation

public final class Course {
    public let courseCode: String
    public let courseName: String
    public let credit: Int
    
    public init(courseCode: String, courseName: String, credit: Int) {
        self.courseCode = courseCode
        self.courseName = courseName
        self.credit = credit
    }
}
