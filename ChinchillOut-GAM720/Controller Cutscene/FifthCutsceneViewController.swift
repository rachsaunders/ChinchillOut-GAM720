//
//  FifthCutsceneViewController.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 18/05/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import UIKit
import AVFoundation

var backgroundSoundEffect5: AVAudioPlayer!

class FifthCutsceneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

         startbackgroundSoundEffect5()
    }
    

    func startbackgroundSoundEffect5() {
          let path = Bundle.main.path(forResource: "chirp3", ofType: "mp3")
          let url = URL(fileURLWithPath: path!)
          backgroundMusicPlayer = try! AVAudioPlayer(contentsOf: url)
         
          backgroundMusicPlayer.play()
      }

}
