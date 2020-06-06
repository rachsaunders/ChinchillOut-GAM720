//
//  L1W1ViewController.swift
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

class L1W1ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startbackgroundMusic()
        
        
        presentW1L1Scene()
        
        
        
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


extension L1W1ViewController: SceneManagerDelegate {
    
    func presentW1L1Scene() {
        let scene = GameSceneL1W1(size: view.bounds.size, sceneManagerDelegate: self)
        scene.scaleMode = .aspectFill
        scene.sceneManagerDelegate = self
        present(scene: scene)
        
        if let view = self.view as! SKView? {
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
          
            
            // TESTING PURPOSES
//            view.showsFPS = true
//            view.showsNodeCount = true
//            view.showsPhysics = true
        }
        
    }
    
    func presentMenuViewController() {
        performSegue(withIdentifier: "backToMenu", sender: nil)
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
