//
//  GameClass.swift
//  oop game
//
//  Created by Jesus Lopez de Nava on 11/16/15.
//  Copyright © 2015 LodenaApps. All rights reserved.
//

import Foundation
import AVFoundation

class GameClass {

//    var vc: ViewController!
//    init(vc: ViewController) {
//        self.vc = vc
//    }
    
    var punch1sound: AVAudioPlayer!
    var punch2sound: AVAudioPlayer!
    var selectedSound: AVAudioPlayer!
    var backgroundMusic: AVAudioPlayer!
    var deathSound: AVAudioPlayer!
    
    
    init() {
        
        punch1sound = initializeSounds("punch1", soundExt: "wav")
        punch2sound = initializeSounds("punch2", soundExt: "wav")
        selectedSound = initializeSounds("selected", soundExt: "wav")
        backgroundMusic = initializeSounds("Level 2", soundExt: "wav")
        deathSound = initializeSounds("gameplay - death yell", soundExt: "wav")
    }
    
    
    func initializeSounds(soundName: String, soundExt: String) -> AVAudioPlayer? {
        
        let sound: AVAudioPlayer!
        let path = NSBundle.mainBundle().pathForResource(soundName, ofType: soundExt)
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try sound = AVAudioPlayer(contentsOfURL: soundUrl)
            sound.prepareToPlay()
            return sound
            
        } catch let err as NSError {
            print(err.debugDescription)
            return nil
        }
        
    }
    
    func playSound(type: Int) {
        
        switch type {
            
        case 1:
            if punch1sound.playing {
                punch1sound.stop()
            }
            punch1sound.play()
            
        case 2:
            if punch2sound.playing {
                punch2sound.stop()
            }
            punch2sound.play()
            
        case 3:
            if selectedSound.playing {
                selectedSound.stop()
            }
            selectedSound.play()
            
        case 4:
            if deathSound.playing {
                deathSound.stop()
            }
            deathSound.play()
            
        case 5:
            if backgroundMusic.playing {
                backgroundMusic.stop()
            }
            backgroundMusic.currentTime = 0.00
            backgroundMusic.numberOfLoops = -1
            backgroundMusic.play()
            
        default: break
            
        }
        
    }

}
