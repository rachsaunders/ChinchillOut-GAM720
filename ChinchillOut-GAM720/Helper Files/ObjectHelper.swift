//
//  ObjectHelper.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 10/05/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import SpriteKit

class ObjectHelper {
    
    static func handleChild(sprite: SKSpriteNode, with name: String) {
        
        switch name {
        case GameConstants.StringConstants.finishLineName, GameConstants.StringConstants.enemyName :
            PhysicsHelper.addPhysicsBody(to: sprite, with: name)
        default:
            break
        }
        
    }
    
}
