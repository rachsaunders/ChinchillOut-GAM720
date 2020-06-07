//
//  L1W2ViewController.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 08/05/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

var halloweenMusicPlayer: AVAudioPlayer!

class L1W2ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startbackgroundHalloweenMusic()
        
        presentW2L1Scene()
        
    }
    
   
}

func startbackgroundHalloweenMusic() {
    let path = Bundle.main.path(forResource: "halloweenBackground", ofType: "mp3")
    let url = URL(fileURLWithPath: path!)
    halloweenMusicPlayer = try! AVAudioPlayer(contentsOf: url)
    halloweenMusicPlayer.numberOfLoops = -1
    halloweenMusicPlayer.play()
}


extension L1W2ViewController: SceneManagerDelegateHalloween {
    
    func presentW2L1Scene() {
        let scene = GameSceneL1W2(size: view.bounds.size, sceneManagerDelegateHalloween: self)
        scene.scaleMode = .aspectFill
        scene.sceneManagerDelegateHalloween = self
        present(scene: scene)
        
        if let view = self.view as! SKView? {
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
          
        }
    }
    
    
    func presentMenuViewController() {
     
      
        performSegue(withIdentifier: "backToMenuHalloween", sender: nil)
        
    }
    
    func present(scene: SKScene) {

        // may delete
        
    }
    
}
