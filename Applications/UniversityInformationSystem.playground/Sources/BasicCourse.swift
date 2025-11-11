//
//  BasicCourse.swift
//
//
//  Created by Enes Eken 2 on 11.11.2025.
//

import Foundation

public final class BasicCourse: Course {
    override public func calculateGrade(_ scores: Double...) -> String {
        guard scores.count == 3 else {
            fatalError("Basic courses require 3 scores (Midterm, Final, Project).")
        }

        let average = (scores[0] * 0.3) + (scores[1] * 0.5) + (scores[2] + 0.2)
        return letterGrade(average)
    }
}
