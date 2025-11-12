//
//  StandardGradeCalculation.swift
//  
//
//  Created by Enes Eken 2 on 11.11.2025.
//

import Foundation

public final class StandardGradeCalculation: GradeCalculationStrategy {
    public init() {} 
    public func calculateAverage(_ grade: ExamGrade) -> Double {
        return (grade.midterm * 0.4) + (grade.final * 0.6)
    }
    
    public func getDescription() -> String {
        return "Standard (40% midterm, 60% final)"
    }
}
