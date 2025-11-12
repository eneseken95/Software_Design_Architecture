//
//  EmailNotificationService.swift
//  
//
//  Created by Enes Eken 2 on 12.11.2025.
//

import Foundation

public final class EmailNotificationService: NotificationService {
public init() {}
   public func sendNotification(subject: String, message: String) {
        print("Email sent: [\(subject)] - \(message)")
    }
}
