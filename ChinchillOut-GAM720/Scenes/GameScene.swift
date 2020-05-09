//
//  GameScene.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 08/05/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var worldLayer: Layer!

    var mapNode: SKNode!
    var tileMap: SKTileMapNode!
    
    var lastTime: TimeInterval = 0
    var dt: TimeInterval = 0
    
    override func didMove(to view: SKView) {
        createLayers()
        
    }
    
    func createLayers() {
        worldLayer = Layer()
        addChild(worldLayer)
        // only move x as player moves right not up
        worldLayer.layerVelocity = CGPoint(x: -200, y: 0.0)
        
        load(level: "Level_0-1")
    }
    
    func load(level: String) {
        if let levelNode = SKNode.unarchiveFromFile(file: level) {
            mapNode = levelNode
            // enable mapnode to move with the layer aka level moves
            worldLayer.addChild(mapNode)
            loadTileMap()
        }
    }
    
    func loadTileMap() {
        // if theres a value for ground tiles it will be SKTileMapNode
        if let groundTiles = mapNode.childNode(withName: "Ground Tiles") as? SKTileMapNode {
            tileMap = groundTiles
            // set to entire size of the frame, width is false because it is ongoing
            tileMap.scale(to: frame.size, width: false, multiplier: 1.0)
            
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
    
        if lastTime > 0 {
            dt = currentTime - lastTime
        } else {
            dt = 0
        }
        lastTime = currentTime
        
        worldLayer.update(dt)
        
    }
}
