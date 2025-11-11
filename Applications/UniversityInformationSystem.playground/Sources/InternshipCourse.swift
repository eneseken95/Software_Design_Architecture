//
//  InternshipCourse.swift
//
//
//  Created by Enes Eken 2 on 11.11.2025.
//

import Foundation

public final class InternshipCourse: Course {
    override public func calculateGrade(_ scores: Double...) -> String {
        guard scores.count == 1 else {
            fatalError("Internship courses require only 1 score (Evaluation).")
        }
        return letterGrade(scores[0])
    }
}
