//
//  SmsNotificationService.swift
//  
//
//  Created by Enes Eken 2 on 12.11.2025.
//

import Foundation

final class SmsNotificationService: NotificationService {
    func sendNotification(subject: String, message: String) {
        print("SMS sent: [\(subject)] - \(message)")
    }
}
