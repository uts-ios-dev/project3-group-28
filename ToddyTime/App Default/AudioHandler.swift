//
//  AudioHandler.swift
//  ToddyTime
//
//  Created by Shankhar on 5/24/18.
//  Copyright © 2018 Shankhar. All rights reserved.
//

import AVFoundation


class AudioHandler {
    
    //themeplayer handles theme song and audioplayer handles animal sound
    private static var audioPlayer: AVAudioPlayer!
    private static var themePlayer: AVAudioPlayer!
    
    static let appMusic = "AppMusic"
    
    // muteAppMusic is set true if you want to mute the app theme sound and is set to false if you dont want to mute it.
    static var muteAppMusic = false {
        didSet {
            if muteAppMusic {
                themePlayer.pause()
            } else {
                themePlayer.play()
            }
        }
    }
    
    
    //plays app's theme music in background in loop
    static func playThemeMusic() {
        if let audioFilePath = Bundle.main.path(forResource: appMusic, ofType: "mp3") {
            let audioFileUrl = URL.init(fileURLWithPath: audioFilePath)
            try! themePlayer = AVAudioPlayer(contentsOf: audioFileUrl)
            themePlayer.numberOfLoops = -1
            themePlayer.play()
        }
    }
    
    
    
    //plays animal sound when called
    static func play(audio: String = "click") {
        if let audioFilePath = Bundle.main.path(forResource: audio, ofType: "mp3") {
            let audioFileUrl = URL.init(fileURLWithPath: audioFilePath)
            try! audioPlayer = AVAudioPlayer(contentsOf: audioFileUrl)
            audioPlayer.numberOfLoops = 0
            audioPlayer.play()
        }
    }
    
}

