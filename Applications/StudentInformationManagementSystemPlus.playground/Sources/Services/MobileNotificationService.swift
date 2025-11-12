//
//  MobileNotificationService.swift
//  
//
//  Created by Enes Eken 2 on 12.11.2025.
//

import Foundation

final class MobileNotificationService: NotificationService {
    func sendNotification(subject: String, message: String) {
        print("Mobile notification sent: [\(subject)] - \(message)")
    }
}
