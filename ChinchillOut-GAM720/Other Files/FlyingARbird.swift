//
//  FlyingARbird.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 21/06/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import SpriteKit
import GameplayKit

class Bird : SKSpriteNode {
 
    var mainSprite = SKSpriteNode()
    
    func setup(){
        
        mainSprite = SKSpriteNode(imageNamed: "birdflying_0")
        self.addChild(mainSprite)
        
        let textureAtals = SKTextureAtlas(named: "bird")
        let frames = ["birdflying_0", "birdflying_1", "birdflying_2", "birdflying_3", "birdflying_4", "birdflying_5", "birdflying_6", "birdflying_7", "birdflying_8", "birdflying_9"].map{textureAtals.textureNamed($0)}
        
        let atlasAnimation = SKAction.animate(with: frames, timePerFrame: 1/7, resize: true, restore: false)
        
        let animationAction = SKAction.repeatForever(atlasAnimation)
        mainSprite.run(animationAction)
        
        
        let left = GKRandomSource.sharedRandom().nextBool()
        if left {
            mainSprite.xScale = -1
        }
        
        let duration = randomNumber(lowerBound: 15, upperBound: 20)
        
        let fade = SKAction.fadeOut(withDuration: TimeInterval(duration))
        let removeBird = SKAction.run {
            NotificationCenter.default.post(name: Notification.Name("Spawn"), object: nil)
            self.removeFromParent()
        }
        
        let flySeqence = SKAction.sequence([fade, removeBird])
        
        mainSprite.run(flySeqence)
        
    }
    
}

