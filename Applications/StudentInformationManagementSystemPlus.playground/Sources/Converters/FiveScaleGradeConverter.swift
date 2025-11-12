//
//  FiveScaleGradeConverter.swift
//
//
//  Created by Enes Eken 2 on 11.11.2025.
//

import Foundation

public final class FiveScaleGradeConverter: LetterGradeConverter {
    override public func convert(_ average: Double) -> String {
        switch average {
        case 85 ... 100: return "AA"
        case 75 ..< 85: return "BA"
        case 65 ..< 75: return "BB"
        case 55 ..< 65: return "CB"
        case 45 ..< 55: return "CC"
        default: return "FF"
        }
    }

    public override func getSystemName() -> String {
        return "5.0 Scale"
    }
}
