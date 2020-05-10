//
//  Player.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 09/05/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import SpriteKit

// define current state of the chinchilla

enum PlayerState {
    case idle, running
}

class Player: SKSpriteNode {

    var runFrames = [SKTexture]()
    var idleFrames = [SKTexture]()
    var jumpFrames = [SKTexture]()
    var dieFrames = [SKTexture]()
    
    // Start off the chinchilla as idle
    var state = PlayerState.idle {
        willSet {
            // call animate to value set state property to
            animate(for: newValue)
        }
    }
    
    var airborne = false
    
    // load all images for frames
    func loadTextures() {
        idleFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerIdleAtlas), withName: GameConstants.StringConstants.idlePrefixKey)
        runFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerRunAtlas), withName: GameConstants.StringConstants.runPrefixKey)
        jumpFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerJumpAtlas), withName: GameConstants.StringConstants.jumpPrefixKey)
        dieFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.playerDieAtlas), withName: GameConstants.StringConstants.diePrefixKey)
        
    }

    func animate(for state: PlayerState) {
        // stop stacking animations on top of one another
        removeAllActions()
        
        switch state {
        case .idle:
            self.run(SKAction.repeatForever(SKAction.animate(with: idleFrames, timePerFrame: 0.17, resize: true, restore: true)))
        case .running:
            // //////////////////////////////////////////////////////////////////////////CHANGED - to false for now but sprite needs resizing in illustrator /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            self.run(SKAction.repeatForever(SKAction.animate(with: runFrames, timePerFrame: 0.2, resize: false, restore: true)))
        }
        
    }
    
    
    
}
