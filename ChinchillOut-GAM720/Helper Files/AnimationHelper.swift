//
//  AnimationHelper.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 10/05/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import SpriteKit

class AnimationHelper {
    
    static func loadTextures(from atlas: SKTextureAtlas, withName name: String) -> [SKTexture] {
        var textures = [SKTexture]()
        // load all animation sprites from 0 onwards
        for index in 0..<atlas.textureNames.count {
            let textureName = name + String(index)
            textures.append(atlas.textureNamed(textureName))

        }
        return textures
    }
    
}
