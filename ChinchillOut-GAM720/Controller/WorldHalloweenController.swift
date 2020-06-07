//
//  WorldHalloweenController.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 06/06/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//
//
import UIKit

class WorldHalloweenController: UIViewController {

   override func viewDidLoad() {
        // fixes error of level music playing on the level selection on worlds view controller
         halloweenMusicPlayer?.stop()
    }
}
