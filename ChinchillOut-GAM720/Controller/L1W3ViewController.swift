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

var xmasMusicPlayer: AVAudioPlayer!

class L1W3ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startbackgroundXmasMusic()
        
        presentW3L1Scene()
        
    }
    
   
}

func startbackgroundXmasMusic() {
    let path = Bundle.main.path(forResource: "xmasBackground", ofType: "mp3")
    let url = URL(fileURLWithPath: path!)
    xmasMusicPlayer = try! AVAudioPlayer(contentsOf: url)
    xmasMusicPlayer.numberOfLoops = -1
    xmasMusicPlayer.play()
}


extension L1W3ViewController: SceneManagerDelegateXmas {
    
    func presentW3L1Scene() {
        let scene = GameSceneL1W3(size: view.bounds.size, sceneManagerDelegateXmas: self)
        scene.scaleMode = .aspectFill
        scene.sceneManagerDelegateXmas = self
        present(scene: scene)
        
        if let view = self.view as! SKView? {
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
          
        }
    }
    
    
    func presentMenuViewController() {
     
      
        performSegue(withIdentifier: "backToMenuXmas", sender: nil)
        
    }
    
    func present(scene: SKScene) {

        // may delete
        
    }
    
}
