import Foundation

// MARK: - Facade Pattern

// MARK: Home Theater Facade

final class Amplifier {
    func on() {
        print("Amp on")
    }
}

final class Player {
    func play(_ movie: String) {
        print("Play: \(movie)")
    }
}

final class Projector {
    func on() {
        print("Projector on")
    }
}

final class Lights {
    func dim(_ level: Int) {
        print("Lights: \(level)%")
    }
}

final class HomeTheaterFacade {
    private let amp: Amplifier
    private let player: Player
    private let projector: Projector
    private let lights: Lights

    init(amp: Amplifier, player: Player, projector: Projector, lights: Lights) {
        self.amp = amp
        self.player = player
        self.projector = projector
        self.lights = lights
    }

    func watchMovie(_ movie: String) {
        amp.on()
        projector.on()
        lights.dim(20)
        player.play(movie)
    }
}

let facade = HomeTheaterFacade(amp: Amplifier(), player: Player(), projector: Projector(), lights: Lights())

facade.watchMovie("The Godfather")

// MARK: Visual Processing Facade

final class Loader {
    func load(_ path: String) -> Any {
        print("Uploaded: \(path)")
        return "IMAGE_DATA"
    }
}

final class Resizer {
    func resize(_ img: Any, _ width: Int, _ height: Int) -> Any {
        print("Resize: \(width)x\(height)")
        return img
    }
}

final class WaterMarker {
    func mark(_ img: Any, _ text: String) -> Any {
        print("Filigran: \(text)")
        return img
    }
}

final class Saver {
    func save(_ img: Any, _ out: String) {
        print("Saved: \(out)")
    }
}

final class ImageProcessingFacade {
    private let loader = Loader()
    private let resizer = Resizer()
    private let waterMarker = WaterMarker()
    private let saver = Saver()

    func process(input: String, output: String, w: Int, h: Int, watermark: String) {
        var img = loader.load(input)
        img = resizer.resize(img, w, h)
        img = waterMarker.mark(img, watermark)
        saver.save(img, output)
    }
}

let imageFacade = ImageProcessingFacade()
ImageProcessingFacade().process(input: "input.jpg", output: "output.jpg", w: 800, h: 600, watermark: "Swift")

// MARK: Notification Facade

struct User {
    let email: String?
    let sms: String?
    let deviceId: String
}

final class EmailClient {
    func send(_ to: String, subject: String, html: String) {
        print("Email -> \(to) | sub: \(subject) | html: \(html)")
    }
}

final class SmsClient {
    func send(_ to: String, _ text: String) {
        print("SMS -> \(to) | text: \(text)")
    }
}

final class PushClient {
    func send(_ device: String, text: String) {
        print("Push -> \(device) | text: \(text)")
    }
}

final class NotificationFacade {
    private let email = EmailClient()
    private let sms = SmsClient()
    private let push = PushClient()

    func notifyOrder(_ user: User, message: String) {
        if let emailAddr = user.email {
            email.send(emailAddr, subject: "Order placed", html: message)
        } else if let phone = user.sms {
            sms.send(phone, message)
        } else {
            push.send(user.deviceId, text: message)
        }
    }
}

let notifier = NotificationFacade()
notifier.notifyOrder(User(email: "user@example.com", sms: nil, deviceId: "device123"), message: "Your order is placed")

// MARK: Weather Client Facade

final class HttpClient {
    func get(_ url: String) -> String {
        print("GET \(url)")
        return #"{"temp":18}"#
    }
}

final class Cache {
    private var map: [String: String] = [:]

    func get(_ key: String) -> String? {
        map[key]
    }

    func put(_ key: String, _ value: String) {
        map[key] = value
    }
}

final class JsonParser {
    func parseTemp(_ json: String) -> Int {
        return 18
    }
}

final class WeatherFacade {
    private let http = HttpClient()
    private let cache = Cache()
    private let parser = JsonParser()

    func getCurrentTemp(city: String) -> Int {
        let key = "WX-\(city)"

        if let cached = cache.get(key) {
            return parser.parseTemp(cached)
        }

        let json = http.get("https://api.example.com/weather?c=\(city)")
        cache.put(key, json)
        return parser.parseTemp(json)
    }
}

let weather = WeatherFacade()
print(weather.getCurrentTemp(city: "Istanbul"))
