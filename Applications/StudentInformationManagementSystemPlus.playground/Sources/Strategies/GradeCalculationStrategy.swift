//
//  GradeCalculationStrategy.swift
//  
//
//  Created by Enes Eken 2 on 11.11.2025.
//

import Foundation

public protocol GradeCalculationStrategy {
    func calculateAverage(_ grade: ExamGrade) -> Double
    func getDescription() -> String
}
