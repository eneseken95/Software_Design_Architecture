//
//  ExamGrade.swift
//  
//
//  Created by Enes Eken 2 on 11.11.2025.
//

import Foundation

public struct ExamGrade {
    public var midterm: Double
    public var final: Double
    
    public init(midterm: Double, final: Double) {
        self.midterm = midterm
        self.final = final
    }
}
