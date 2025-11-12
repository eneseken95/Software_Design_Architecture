import Foundation

// MARK: - Product

protocol Document {
    func open()
}

// MARK: - Concrete Products

final class WordDocument: Document {
    func open() {
        print("Word Document opened.")
    }
}

final class PDFDocument: Document {
    func open() {
        print("PDF Document opened.")
    }
}

// MARK: - Creator

class Application {
    func createDocument() -> Document {
        fatalError("Subclass must override createDocument()")
    }

    func openDocument() {
        let doc = createDocument()
        doc.open()
    }
}

// MARK: - Concrete Creators

final class WordApplication: Application {
    override func createDocument() -> Document {
        return WordDocument()
    }
}

final class PDFApplication: Application {
    override func createDocument() -> Document {
        return PDFDocument()
    }
}

// MARK: - Client Usage

let app = PDFApplication()
app.openDocument()

// MARK: - Dynamic Factory

enum DocumentType {
    case word, pdf
}

final class DynamicApp: Application {
    override func createDocument() -> Document {
        return PDFDocument()
    }

    func switchCreateDocument(type: DocumentType) -> Document {
        switch type {
        case .word:
            return WordDocument()
        case .pdf:
            return PDFDocument()
        }
    }
}

let app2 = DynamicApp()
app2.switchCreateDocument(type: .word).open()
