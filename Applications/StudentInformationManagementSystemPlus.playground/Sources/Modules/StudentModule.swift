//
//  StudentModule.swift
//
//
//  Created by Enes Eken 2 on 11.11.2025.
//

import Foundation

public final class StudentModule {
    var calculationStrategy: GradeCalculationStrategy
    var converter: LetterGradeConverter

   public init(calculationStrategy: GradeCalculationStrategy, converter: LetterGradeConverter) {
        self.calculationStrategy = calculationStrategy
        self.converter = converter
    }

   public func calculateAndConvert(grade: ExamGrade) -> String {
        let avg = calculationStrategy.calculateAverage(grade)
        let letter = converter.convert(avg)
        return "Average: \(avg), Letter: \(letter)"
    }
}
