//
//  GameViewController.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 08/05/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

// NOTES
// I've set the landscape mode to be disabled. iOS is targeted at iOS11+. Test builds have been used on my phone which runs 13.4.1 on an iPhone 8 model.

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            
            // Scene is visable within view of device, entire screen used
            let scene = GameScene(size: view.bounds.size)
            scene.scaleMode = .aspectFill
            
            // Present the scene (constant was named scene above)
            view.presentScene(scene)
            
            // child nodes won't follow an order
            view.ignoresSiblingOrder = true
            
            // **Do not include in actual game** //
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsPhysics = true
            ////////////////////////////////////////////////////////////////////////////////////
            
        }
        
    }
}


//extension GameViewController: SceneManagerDelegate {
//    
//    func presentMenuScene() {
//        
//        
//    }
//    
//    func presentLevelScene(for world: Int) {
//        
//        
//        }
//    
//    func presentGameScene(for level: Int, in world: Int) {
//        
//        
//    }
//    
//    func present(scene: SKScene) {
//        
//    }
//    
//}
