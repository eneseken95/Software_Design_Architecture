import Foundation

// MARK: ISP – Interface Segregation Principle

protocol EmailNotifiable {
    func sendEmail()
}

protocol SMSNotifiable {
    func sendSMS()
}

protocol PushNotifiable {
    func sendPush()
}

final class EmailService: EmailNotifiable {
    func sendEmail() {
        print("Sending email")
    }
}

final class SMSService: SMSNotifiable {
    func sendSMS() {
        print("Sending SMS")
    }
}
