import Foundation

// MARK: - Adapter Pattern

// MARK: - Class Adapter

// MARK: Mp4 Media Player Adapter

protocol MediaPlayer {
    func play(file: String)
}

class Mp4Player {
    func playMp4(_ file: String) {
        print("Playing MP4 (Adaptee): \(file)")
    }
}

final class Mp4ClassAdapter: Mp4Player, MediaPlayer {
    func play(file: String) {
        playMp4(file)
    }
}

let player: MediaPlayer = Mp4ClassAdapter()
player.play(file: "music.mp4")

// MARK: - Object Adapter

// MARK: Mp4 Media Player Adapter

final class Mp4ObjectAdapter: MediaPlayer {
    private let adaptee = Mp4Player()

    func play(file: String) {
        adaptee.playMp4(file)
    }
}

let player2: MediaPlayer = Mp4ObjectAdapter()
player.play(file: "video.mp4")

// MARK: Advanced Media Player Adapter

final class AdvancedMp4Player {
    func playMp4(_ file: String) {
        print("MP4: \(file)")
    }
}

final class AdvancedFlacPlayer {
    func playFlac(_ file: String) {
        print("FLAC: \(file)")
    }
}

final class Mp4Adapter: MediaPlayer {
    private let player = AdvancedMp4Player()

    func play(file: String) {
        player.playMp4(file)
    }
}

final class FlacAdapter: MediaPlayer {
    private let player = AdvancedFlacPlayer()

    func play(file: String) {
        player.playFlac(file)
    }
}

final class MediaPlayerFactory {
    static func makePlayer(_ file: String) -> MediaPlayer {
        let ext = file.split(separator: ".").last ?? ""

        switch ext {
        case "mp4":
            return Mp4Adapter()
        case "flac":
            return FlacAdapter()
        default:
            fatalError("Unsupported format")
        }
    }
}

let player3 = MediaPlayerFactory.makePlayer("video.mp4")
player3.play(file: "video.mp4")

// MARK: Payment Processor Adapter

enum PaymentProvider {
    case stripe
    case paypal
}

protocol PaymentProcessor {
    func charge(cardNo: String, amountTL: Double)
}

final class StripeSDK {
    func payCents(card: String, cents: Int) {
        print("Stripe → charged \(cents) cents to \(card)")
    }
}

final class PayPalSDK {
    func payUSD(email: String, dollars: Double) {
        print("PayPal → charged \(dollars) USD to \(email)")
    }
}

final class StripeAdapter: PaymentProcessor {
    private let sdk: StripeSDK

    init(sdk: StripeSDK) {
        self.sdk = sdk
    }

    func charge(cardNo: String, amountTL: Double) {
        let cents = Int(amountTL * 100)
        sdk.payCents(card: cardNo, cents: cents)
    }
}

final class PayPalAdapter: PaymentProcessor {
    private let sdk: PayPalSDK

    init(sdk: PayPalSDK) {
        self.sdk = sdk
    }

    func charge(cardNo: String, amountTL: Double) {
        let usd = amountTL / 32.0
        sdk.payUSD(email: cardNo, dollars: usd)
    }
}

final class paymentProcessorFactory {
    static func make(_ provider: PaymentProvider) -> PaymentProcessor {
        switch provider {
        case .stripe:
            return StripeAdapter(sdk: StripeSDK())

        case .paypal:
            return PayPalAdapter(sdk: PayPalSDK())
        }
    }
}

final class CheckoutService {
    private let processor: PaymentProcessor

    init(processor: PaymentProcessor) {
        self.processor = processor
    }

    func payOrder(_ cardNo: String, _ amountTL: Int) {
        processor.charge(cardNo: cardNo, amountTL: Double(amountTL))
    }
}

let processor = paymentProcessorFactory.make(.stripe)
CheckoutService(processor: processor).payOrder("4111-1111-1111-1111", 200)

// MARK: Logger Adapter

protocol SimpleLogger {
    func info(_ msg: String)
    func error(_ msg: String)
}

class LegacyLogger {
    static let infoLevel = 1
    static let errorLevel = 2

    func write(_ level: Int, _ msg: String) {
        let levelText = (level == 1) ? "INFO" : "ERROR"
        print("LEGACY: [\(levelText)] \(msg)")
    }
}

final class LegacyLoggerAdapter: LegacyLogger, SimpleLogger {
    func info(_ msg: String) {
        write(Self.infoLevel, msg)
    }

    func error(_ msg: String) {
        write(Self.errorLevel, msg)
    }
}

final class ReportService {
    private let logger: SimpleLogger

    init(logger: SimpleLogger) {
        self.logger = logger
    }

    func run() {
        logger.info("Report started")
        logger.error("No data found")
    }
}

ReportService(logger: LegacyLoggerAdapter()).run()

// MARK: Message Queue Adapter

protocol QueueClient {
    func send(topic: String, data: Data)
}

final class RabbitPublisher {
    func publish(exchange: String, routingKey: String, payload: Data) {
        print("Rabbit → exchange: \(exchange), key: \(routingKey), bytes: \(payload.count)")
    }
}

final class RabbitAdapter: QueueClient {
    private let publisher: RabbitPublisher
    private let exchange: String

    init(publisher: RabbitPublisher, exchange: String) {
        self.publisher = publisher
        self.exchange = exchange
    }

    func send(topic: String, data: Data) {
        publisher.publish(exchange: exchange, routingKey: topic, payload: data)
    }
}

let queue: QueueClient = RabbitAdapter(publisher: RabbitPublisher(), exchange: "app.exchange")
queue.send(topic: "order.created", data: Data("{\"id\":42}".utf8))
