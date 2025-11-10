import Foundation

// MARK: SRP – Single Responsibility Principle

final class OrderService {
    func createOrder() -> String {
        return "Order Created"
    }
}

final class InvoiceService {
    func genreateInvoice() -> String {
        return "Invoice Generated"
    }
}

final class EmailService {
    func sendEmail() -> String {
        return "Email Sent"
    }
}

let orderService = OrderService()
let invoiceService = InvoiceService()
let emailService = EmailService()

orderService.createOrder()
invoiceService.genreateInvoice()
emailService.sendEmail()
