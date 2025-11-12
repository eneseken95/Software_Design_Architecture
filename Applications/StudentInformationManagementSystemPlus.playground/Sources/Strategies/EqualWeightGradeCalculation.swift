//
//  EqualWeightGradeCalculation.swift
//  
//
//  Created by Enes Eken 2 on 11.11.2025.
//

import Foundation

public final class EqualWeightGradeCalculation: GradeCalculationStrategy {
   public func calculateAverage(_ grade: ExamGrade) -> Double {
        return (grade.midterm + grade.final) / 2
    }
    
   public func getDescription() -> String {
        return "Equal weight (50% midterm, 50% final)"
    }
}
