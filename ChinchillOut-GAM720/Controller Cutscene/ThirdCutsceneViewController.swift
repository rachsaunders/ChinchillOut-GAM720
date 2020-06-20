//
//  ThirdCutsceneViewController.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 18/05/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import UIKit
import AVFoundation

var backgroundSoundEffect3: AVAudioPlayer!

class ThirdCutsceneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
          startbackgroundSoundEffect3()

       
    }
    
    func startbackgroundSoundEffect3() {
        let path = Bundle.main.path(forResource: "chirp2", ofType: "mp3")
        let url = URL(fileURLWithPath: path!)
        backgroundMusicPlayer = try! AVAudioPlayer(contentsOf: url)
       
        backgroundMusicPlayer.play()
    }

}
