//
//  PracticalCourse.swift
//
//
//  Created by Enes Eken 2 on 11.11.2025.
//

import Foundation

public final class PracticalCourse: Course {
    override public func calculateGrade(_ scores: Double...) -> String {
        guard scores.count == 2 else {
            fatalError("Practical courses require 2 scores (Practice, Project).")
        }
        let average = (scores[0] * 0.6) + (scores[1] * 0.4)
        return letterGrade(average)
    }
}
