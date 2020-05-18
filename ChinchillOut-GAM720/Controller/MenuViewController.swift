//
//  MenuViewController.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 18/05/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

// NOTES
// changed the view controller in the storyboard to link up to this file, also has the class was changed to SKView in the view controller on the storyboards also. 

class MenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // IF CHANGING IT TO AN SKVIEW UNCOMMENT THE FOLLOWING OTHERWISE STICK TO STORYBOARD DESIGNING
//        if let view = self.view as! SKView? {
//            
//            // Scene is visable within view of device, entire screen used
//            let scene = MenuScene(size: view.bounds.size)
//            scene.scaleMode = .aspectFill
//
//            // Present the scene (constant was named scene above)
//            view.presentScene(scene)
//
//            // child nodes won't follow an order
//            view.ignoresSiblingOrder = true
//
//            // **Do not include in actual game** //
//            view.showsFPS = true
//            view.showsNodeCount = true
//            view.showsPhysics = true
//            ////////////////////////////////////////////////////////////////////////////////////
//
//        }
        
    }
}

