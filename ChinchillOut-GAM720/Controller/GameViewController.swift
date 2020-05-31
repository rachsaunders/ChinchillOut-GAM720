//
//  GameViewController.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 08/05/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation
// import GameplayKit

// NOTES
// I've set the landscape mode to be disabled. iOS is targeted at iOS11+. Test builds have been used on my phone which runs 13.4.1 on an iPhone 8 model.

var backgroundMusicPlayer: AVAudioPlayer!

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // startbackgroundMusic()
        
//        if let view = self.view as! SKView? {
//
//            // Scene is visable within view of device, entire screen used
//            let scene = GameScene(size: view.bounds.size)
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
        
        presentMenuScene()
        
        
        
    }
    
    func startbackgroundMusic() {
        let path = Bundle.main.path(forResource: "forestBackground", ofType: "mp3")
        let url = URL(fileURLWithPath: path!)
        backgroundMusicPlayer = try! AVAudioPlayer(contentsOf: url)
        // constant loop
        backgroundMusicPlayer.numberOfLoops = -1
        backgroundMusicPlayer.play()
    }
}


extension GameViewController: SceneManagerDelegate {
    
    func presentMenuScene() {
        let scene = GameScene(size: view.bounds.size, sceneManagerDelegate: self)
        scene.scaleMode = .aspectFill
        scene.sceneManagerDelegate = self
        present(scene: scene)
        
        if let view = self.view as! SKView? {
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsPhysics = true
        }
        
    }
    
   
    
    
    
    func present(scene: SKScene) {
//        if let view = self.view as! SKView? {
//                   view.presentScene(scene)
//                   
//                   view.ignoresSiblingOrder = true
//                   
//                   view.showsFPS = true
//                   view.showsNodeCount = true
//                   view.showsPhysics = true
//               }
    }
    
}
