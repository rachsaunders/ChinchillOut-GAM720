//
//  W1L4MenuScene.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 21/06/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import SpriteKit
import ARKit

class MainMenuScene: SKScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {return}
        let positionInScene = touch.location(in: self)
        let touchedNodes = self.nodes(at: positionInScene)
        
        if let name = touchedNodes.last?.name {
            if name == "startARGame" {
                let transition = SKTransition.crossFade(withDuration: 0.9)
                
                guard let sceneView = self.view as? ARSKView else {return}
                
                if let gameScene = GameScene(fileNamed: "Level_0-4") {
                    sceneView.presentScene(gameScene, transition: transition)
                }
            }
        }
        
        
    }
    
}
