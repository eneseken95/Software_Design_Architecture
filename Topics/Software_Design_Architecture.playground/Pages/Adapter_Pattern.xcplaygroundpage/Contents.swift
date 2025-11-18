import Foundation

// MARK: - Adapter Pattern

// MARK: - Class Adapter

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

final class Mp4ObjectAdapter: MediaPlayer {
    private let adaptee = Mp4Player()

    func play(file: String) {
        adaptee.playMp4(file)
    }
}

let player2: MediaPlayer = Mp4ObjectAdapter()
player.play(file: "video.mp4")
