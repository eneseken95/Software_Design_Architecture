//
//  WeightedGradeCalculation.swift
//  
//
//  Created by Enes Eken 2 on 11.11.2025.
//

import Foundation

public final class WeightedGradeCalculation: GradeCalculationStrategy {
    public func calculateAverage(_ grade: ExamGrade) -> Double {
        return (grade.midterm * 0.3) + (grade.final * 0.7)
    }
    
   public func getDescription() -> String {
        return "Weighted (30% midterm, 70% final)"
    }
}
