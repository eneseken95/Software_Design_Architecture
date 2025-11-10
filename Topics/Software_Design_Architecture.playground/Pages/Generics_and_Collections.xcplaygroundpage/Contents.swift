import Foundation

// MARK: - Generics

struct Box<T> {
    var value: T
}

// MARK: - Protocols with Associated Types

protocol IdentifiableEntity {
    associatedtype ID: Hashable
    var id: ID { get }
}

// MARK: - Data Transfer Object (DTO)

struct CourseDTO: IdentifiableEntity {
    let id: UUID
    let title: String
}

// MARK: - Generic Repository Pattern

final class InMemoryRepository<T: IdentifiableEntity> {
    // MARK: - Dictionary with Generic Key and Value

    private var storage: [T.ID: T] = [:]

    func save(_ entity: T) {
        storage[entity.id] = entity
    }

    func all() -> [T] {
        Array(storage.values)
    }
}

// MARK: - Example Usage (UUID-based Generic Repository)

let repo = InMemoryRepository<CourseDTO>()
let c = CourseDTO(id: UUID(), title: "Clean Architecture")
repo.save(c)
print(repo.all())
print(repo.all().count)

// MARK: - Protocol Constraints (Generic Bound)

protocol HasID {
    var id: String { get }
}

// MARK: - Model Conforming to HasID

struct Course: HasID {
    let id: String
    let title: String
}

// MARK: - Generic Repository with String-based ID

final class Repo<T: HasID> {
    private var storage: [String: T] = [:]

    func save(_ entity: T) {
        storage[entity.id] = entity
    }

    func all() -> [T] {
        Array(storage.values)
    }
}

// MARK: - Example Usage (String-based Repository)

let repos = Repo<Course>()
repos.save(Course(id: "1", title: "Clean Architecture"))
repos.save(Course(id: "2", title: "Software Design"))

print(repos.all())
