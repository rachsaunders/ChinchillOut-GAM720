//
//  SoundPlayer.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 28/05/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import SpriteKit

class SoundPlayer {
    
    let buttonSound = SKAction.playSoundFileNamed("button", waitForCompletion: false)
    let fruitSound = SKAction.playSoundFileNamed("fruit", waitForCompletion: false)
    let deathSound = SKAction.playSoundFileNamed("gameover", waitForCompletion: false)
    let completedSound = SKAction.playSoundFileNamed("completed", waitForCompletion: false)
    let powerUpSound = SKAction.playSoundFileNamed("powerup", waitForCompletion: false)
    
}
