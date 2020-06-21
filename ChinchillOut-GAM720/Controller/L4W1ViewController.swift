//
//  L4W1ViewController.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 21/06/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//


import UIKit
import SpriteKit
import ARKit

class L4W1ViewController: UIViewController {
    
    
    
    @IBOutlet weak var sceneView: ARSKView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and node count
//        sceneView.showsFPS = true
//        sceneView.showsNodeCount = true
       
        // Load the SKScene from 'Scene.sks'
        if let scene = MainMenuScene(fileNamed: "L4MenuScene") {
            sceneView.presentScene(scene)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    


}
// MARK: - ARSKViewDelegate
extension L4W1ViewController: ARSKViewDelegate {
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        
        if GameScene.gameState == .spawnEvilBirds {
            let bird = Bird()
            bird.setup()
            return bird
        }else{
            return SKNode()
        }
        
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}

