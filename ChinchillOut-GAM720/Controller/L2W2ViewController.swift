//
//  L2W2ViewController.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 20/06/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

var halloweenMusicPlayerL2: AVAudioPlayer!

class L2W2ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startbackgroundHalloweenMusicL2()
        
        presentW2L2Scene()
        
    }
    
   
}

func startbackgroundHalloweenMusicL2() {
    let path = Bundle.main.path(forResource: "halloweenBackground", ofType: "mp3")
    let url = URL(fileURLWithPath: path!)
    halloweenMusicPlayerL2 = try! AVAudioPlayer(contentsOf: url)
    halloweenMusicPlayerL2.numberOfLoops = -1
    halloweenMusicPlayerL2.play()
}


extension L2W2ViewController: SceneManagerDelegateHalloweenL2 {
    
    func presentW2L2Scene() {
        let scene = GameSceneL2W2(size: view.bounds.size, sceneManagerDelegateHalloweenL2: self)
        scene.scaleMode = .aspectFill
        scene.sceneManagerDelegateHalloweenL2 = self
        present(scene: scene)
        
        if let view = self.view as! SKView? {
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
          
        }
    }
    
    
    func presentMenuViewController() {
     
      halloweenMusicPlayerL2.stop()
        performSegue(withIdentifier: "backToMenuHalloweenL2", sender: nil)
        
    }
    
    func present(scene: SKScene) {

        // may delete
        
    }
    
}
