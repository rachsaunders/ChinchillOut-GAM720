//
//  L2W1ViewController.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 20/06/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation


 var backgroundMusicPlayerL2: AVAudioPlayer!

class L2W1ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startbackgroundMusic()
        presentW1L2Scene()
        
        
    }
    
    func startbackgroundMusic() {
        let path = Bundle.main.path(forResource: "forestBackground", ofType: "mp3")
        let url = URL(fileURLWithPath: path!)
        backgroundMusicPlayer = try! AVAudioPlayer(contentsOf: url)
        backgroundMusicPlayer.numberOfLoops = -1
        backgroundMusicPlayer.play()
    }
}


extension L2W1ViewController: SceneManagerDelegateL2 {
    func presentW2L1Scene() {
     
    }
    
    
    func presentW1L2Scene() {
        let scene = GameSceneL2W1(size: view.bounds.size, sceneManagerDelegateL2: self)
        scene.scaleMode = .aspectFill
        scene.sceneManagerDelegateL2 = self
        present(scene: scene)
        
        if let view = self.view as! SKView? {
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
          

        }
        
    }
    
    func presentMenuViewController() {
        performSegue(withIdentifier: "L2backToMenu", sender: nil)
    }
    
    
    func present(scene: SKScene) {

    }
    
}
