//
//  PhysicsHelper.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 10/05/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import SpriteKit

// TileSets.sks tiles have a property of - ground boolean 1. Used for physics properties.

class PhysicsHelper {
    
    static func addPhysicsBody(to sprite: SKSpriteNode, with name: String) {
        
        switch name {
            // Physics of the chinchilla
        case GameConstants.StringConstants.playerName:
            sprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sprite.size.width/2, height: sprite.size.height))
            // make sure chinchilla doesn't bounce back when hitting a physics property on another object/item/tile
            sprite.physicsBody!.restitution = 0.0
            // don't turn the chinchilla
            sprite.physicsBody!.allowsRotation = false
        default:
            sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
        }
        
        
    }
    
    static func addPhysicsBody(to tileMap: SKTileMapNode, and tileInfo: String) {
        
        let tileSize = tileMap.tileSize
        
        for row in 0..<tileMap.numberOfRows {
            var tiles = [Int]()
            for col in 0..<tileMap.numberOfColumns {
                let tileDefinition = tileMap.tileDefinition(atColumn: col, row: row)
                // Defined in the TileSet file on the tiles
                let isUsedTile = tileDefinition?.userData?[tileInfo] as? Bool
                // Defined in the TileSet file on the tiles
                if (isUsedTile ?? false) {
                    tiles.append(1)
                } else {
                    tiles.append(0)
                }
            }
            
            // check if theres a ground tile (defined in TileSet file)
            if tiles.contains(1) {
                var platform = [Int]()
                // check if theres multiple ground tiles
                for (index,tile) in tiles.enumerated() {
                    if tile == 1 && index < (tileMap.numberOfColumns - 1) {
                        platform.append(index)
                    } else if !platform.isEmpty {
                        // first index of platform times width of tiles
                        let x = CGFloat(platform[0]) * tileSize.width
                        // pass the row and times by height of tile
                        let y = CGFloat(row) * tileSize.height
                        
                        // check number of tiles in platform and multiply by width of 1 tile, always height of 1 tile
                        let tileNode = GroundNode(with: CGSize(width: tileSize.width * CGFloat(platform.count), height: tileSize.height))
                        
                        tileNode.position = CGPoint(x: x, y: y)
                        tileNode.anchorPoint = CGPoint.zero
                        tileMap.addChild(tileNode)
                        
                        platform.removeAll()
                    }
                }
                
                
            }
        }
        
    }
    
}
