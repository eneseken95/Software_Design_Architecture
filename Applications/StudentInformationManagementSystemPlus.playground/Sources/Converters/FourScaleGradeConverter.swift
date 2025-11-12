//
//  FourScaleGradeConverter.swift
//
//
//  Created by Enes Eken 2 on 11.11.2025.
//

import Foundation

public final class FourScaleGradeConverter: LetterGradeConverter {
    public override init() {}
    override public func convert(_ average: Double) -> String {
        switch average {
        case 90 ... 100: return "A"
        case 80 ..< 90: return "B"
        case 70 ..< 80: return "C"
        case 60 ..< 70: return "D"
        default: return "F"
        }
    }

    public override func getSystemName() -> String {
        return "4.0 Scale"
    }
}
