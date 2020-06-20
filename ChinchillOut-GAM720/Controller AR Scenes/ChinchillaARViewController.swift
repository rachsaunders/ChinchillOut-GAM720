//
//  ChinchillaARViewController.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 11/06/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import AVFoundation

var backgroundSoundEffectAR: AVAudioPlayer!

let kStartingPosition = SCNVector3(0, -20, -20)

class ChinchillaARViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    var chinchilla = ChinchillaARModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScene()
        
        startbackgroundSoundEffectAR()
        
    }
    
    func startbackgroundSoundEffectAR() {
        let path = Bundle.main.path(forResource: "chinchillaAR", ofType: "mp3")
        let url = URL(fileURLWithPath: path!)
        backgroundMusicPlayer = try! AVAudioPlayer(contentsOf: url)
       
        backgroundMusicPlayer.play()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupConfiguration()
        addChinchilla()
    }
    
    func addChinchilla() {
        chinchilla.loadModel()
        chinchilla.position = kStartingPosition
   //     chinchilla.rotation = SCNVector4Zero
        sceneView.scene.rootNode.addChildNode(chinchilla)
    }
    
    // MARK: - setup
    func setupScene() {
        let scene = SCNScene()
        sceneView.scene = scene
        
    }
    
    func setupConfiguration() {
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
}

