//
//  AudioPlayer.swift
//  asdfghjkl
//
//  Created by Intan Saliya Utomo on 24/05/23.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String){
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            try AVAudioSession.sharedInstance().setCategory(.playback)
            audioPlayer?.play()
        } catch {
            print("Could not play the sound file.")
        }
    }
}
