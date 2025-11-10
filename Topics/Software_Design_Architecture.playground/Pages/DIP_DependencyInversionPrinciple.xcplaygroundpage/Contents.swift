import Foundation

// MARK: DIP – Dependency Inversion Principle

protocol ReportRepository {
    func saveReport(_ content: String)
}

final class MySQLRepository: ReportRepository {
    func saveReport(_ content: String) {
        print("MySQL: Saving report to database...")
    }
}

final class ReportService {
    private let repository: ReportRepository

    init(repository: ReportRepository) {
        self.repository = repository
    }

    func createReport() {
        repository.saveReport("Monthly Report")
    }
}

let repo = MySQLRepository()
let service = ReportService(repository: repo)
service.createReport()
