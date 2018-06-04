//
//  AudioHandler.swift
//  ToddyTime
//
//  Created by Bipin on 5/24/18.
//  Copyright © 2018 Shankhar. All rights reserved.
//

import AVFoundation


class AudioHandler {
    
    private static var audioPlayer: AVAudioPlayer!
    private static var themePlayer: AVAudioPlayer!
    
    static let appMusic = "AppMusic"
    static var muteAppMusic = false {
        didSet {
            if muteAppMusic {
                themePlayer.pause()
            } else {
                themePlayer.play()
            }
        }
    }
    
    static func playThemeMusic() {
        if let audioFilePath = Bundle.main.path(forResource: appMusic, ofType: "mp3") {
            let audioFileUrl = URL.init(fileURLWithPath: audioFilePath)
            try! themePlayer = AVAudioPlayer(contentsOf: audioFileUrl)
            themePlayer.numberOfLoops = -1
            themePlayer.play()
        }
    }
    
    
    static func play(audio: String = "click") {
        if let audioFilePath = Bundle.main.path(forResource: audio, ofType: "mp3") {
            let audioFileUrl = URL.init(fileURLWithPath: audioFilePath)
            try! audioPlayer = AVAudioPlayer(contentsOf: audioFileUrl)
            audioPlayer.numberOfLoops = 0
            audioPlayer.play()
        }
    }
    
}

