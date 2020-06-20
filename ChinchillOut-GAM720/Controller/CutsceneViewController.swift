//
//  CutsceneController.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 18/05/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//
//
import UIKit
import AVFoundation

var backgroundSoundEffect1: AVAudioPlayer!

class CutsceneViewController: UIViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startbackgroundSoundEffect1()

        // Do any additional setup after loading the view.
    }
    
    func startbackgroundSoundEffect1() {
        let path = Bundle.main.path(forResource: "washingmachine", ofType: "mp3")
        let url = URL(fileURLWithPath: path!)
        backgroundMusicPlayer = try! AVAudioPlayer(contentsOf: url)
       
        backgroundMusicPlayer.play()
    }

}
