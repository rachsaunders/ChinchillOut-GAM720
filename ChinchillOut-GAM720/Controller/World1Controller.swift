//
//  World1Controller.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 18/05/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//
//
import UIKit

class World1Controller: UIViewController {

    override func viewDidLoad() {
        // fixes error of level music playing on the level selection on worlds view controller
         backgroundMusicPlayer!.stop()
    }
}
