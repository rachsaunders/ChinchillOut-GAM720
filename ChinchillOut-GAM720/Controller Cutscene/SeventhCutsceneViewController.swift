//
//  SeventhCutsceneViewController.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 18/05/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import UIKit
import AVFoundation

class SeventhCutsceneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
      stopbackgroundSoundEffect6()

     
        // ITS SILENT SO NO BIRD SOUNDS
    }
    
    func stopbackgroundSoundEffect6() {
            
                 backgroundMusicPlayer.stop()
             }
  
    

 

}
