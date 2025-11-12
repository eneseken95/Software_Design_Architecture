import Foundation

// MARK: - Database Singleton

@MainActor
final class Database {
    public static let shared = Database()

    private init() {
        print("Database initialized.")
    }

    func connect() {
        print("Connected to database.")
    }
}

// MARK: Usage Example

Database.shared.connect()
Database.shared.connect()

// MARK: - Logger Singleton

@MainActor
final class Logger {
    static let shared = Logger()

    private init() {}

    func log(_ message: String) {
        print("Log: \(message)")
    }
}

// MARK: Usage Example

Logger.shared.log("Application started.")
Logger.shared.log("User logged in.")

// MARK: - AppConfig Singleton

@MainActor
final class AppConfig {
    static let shared = AppConfig()

    private init() {
        load()
    }

    private var settings: [String: String] = [:]

    private func load() {
        settings["api_url"] = "https://api.example.com"
        settings["theme"] = "dark"
    }

    func get(_ key: String) -> String? {
        return settings[key]
    }
}

// MARK: Usage Example

if let api = AppConfig.shared.get("api_url") {
    print("API URL: ", api)
}
