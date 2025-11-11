//
//  Professor.swift
//
//
//  Created by Enes Eken 2 on 11.11.2025.
//

import Foundation

public struct Professor {
    public let fullName: String
    public let title: String

    public init(fullName: String, title: String) {
        self.fullName = fullName
        self.title = title
    }

    public func getNameSurname() -> String {
        return fullName
    }
}
