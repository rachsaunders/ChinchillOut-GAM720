//
//  L2W3ViewController.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 20/06/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

var xmasMusicPlayerL2: AVAudioPlayer!

class L2W3ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startbackgroundXmasMusicL2()
        
        presentW3L2Scene()
        
    }
    
   
}

func startbackgroundXmasMusicL2() {
    let path = Bundle.main.path(forResource: "xmasBackground", ofType: "mp3")
    let url = URL(fileURLWithPath: path!)
    xmasMusicPlayerL2 = try! AVAudioPlayer(contentsOf: url)
    xmasMusicPlayerL2.numberOfLoops = -1
    xmasMusicPlayerL2.play()
}


extension L2W3ViewController: SceneManagerDelegateXmasL2 {
    
    func presentW3L2Scene() {
        let scene = GameSceneL2W3(size: view.bounds.size, sceneManagerDelegateXmasL2: self)
        scene.scaleMode = .aspectFill
        scene.sceneManagerDelegateXmasL2 = self
        present(scene: scene)
        
        if let view = self.view as! SKView? {
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
          
        }
    }
    
    
    func presentMenuViewController() {
     
      xmasMusicPlayerL2.stop()

        performSegue(withIdentifier: "backToMenuXmasL2", sender: nil)
        
    }
    
    func present(scene: SKScene) {

        // may delete
        
    }
    
}
