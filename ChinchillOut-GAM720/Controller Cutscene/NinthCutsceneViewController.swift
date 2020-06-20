//
//  NinthCutsceneViewController.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 18/05/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import UIKit
import AVFoundation

var backgroundSoundEffect9: AVAudioPlayer!

class NinthCutsceneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        startbackgroundSoundEffect9()
        
    }
    
    func startbackgroundSoundEffect9() {
        let path = Bundle.main.path(forResource: "BirdsSwearingLong", ofType: "mp3")
        let url = URL(fileURLWithPath: path!)
        backgroundMusicPlayer = try! AVAudioPlayer(contentsOf: url)
       
        backgroundMusicPlayer.play()
        
         backgroundMusicPlayer.numberOfLoops = -1
    }


}
