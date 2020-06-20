//
//  SixthCutsceneViewController.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 18/05/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import UIKit
import AVFoundation

var backgroundSoundEffect6: AVAudioPlayer!

class SixthCutsceneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        startbackgroundSoundEffect6()
        
    }

    
       func startbackgroundSoundEffect6() {
           let path = Bundle.main.path(forResource: "birdsswearing", ofType: "mp3")
           let url = URL(fileURLWithPath: path!)
           backgroundMusicPlayer = try! AVAudioPlayer(contentsOf: url)
        backgroundMusicPlayer.setVolume(0.1, fadeDuration: 0)
     //   backgroundMusicPlayer.numberOfLoops = -1
           backgroundMusicPlayer.play()
       }
    
   //

    
    

  
}
