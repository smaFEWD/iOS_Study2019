//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 27/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    var audioPlayer: AVAudioPlayer!
    // this means we are using a global variable (case 1)
    // we want to avoid using a global variable, so we comment it out.
//    var selectedSoundFileName : String = ""
    
    let soundArray = ["note1","note2","note3","note4","note5","note6","note7"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }



    @IBAction func notePressed(_ sender: UIButton) {
        // in case 1, selectedSoundFileName is "note1", etc etc etc
        // this below is using the global variable ( case 1) since it was already declared globally outside of this function
//       selectedSoundFileName = soundArray[sender.tag - 1]
        
        // case 1, no arguments
//        playSound()
        // using case 2, we now will play this function with the argument
        playSound(soundFileName: soundArray[sender.tag - 1])
    }
    
    // case 2 means we will accept an input in this function
    func playSound(soundFileName : String) {
        //using the global variable, case 1
//        let soundURL = Bundle.main.url(forResource: selectedSoundFileName, withExtension: "wav")
        
        // not using it as a global variable, case 2
        let soundURL = Bundle.main.url(forResource: soundFileName, withExtension: "wav")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL!)
        }
        catch {
            print(error)
        }
        audioPlayer.play()
    }
    
    
  

}

