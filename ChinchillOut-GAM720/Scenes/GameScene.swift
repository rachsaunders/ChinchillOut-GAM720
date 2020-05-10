//
//  GameScene.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 08/05/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import SpriteKit

enum GameState {
    case ready, ongoing, paused, finished
}

class GameScene: SKScene {
    
    var worldLayer: Layer!
    
    var backgroundLayer: RepeatingLayer!

    var mapNode: SKNode!
    var tileMap: SKTileMapNode!
    
    var lastTime: TimeInterval = 0
    var dt: TimeInterval = 0
    
    var gameState = GameState.ready
    
    var player: Player!
    
    override func didMove(to view: SKView) {
        createLayers()
        
    }
    
    func createLayers() {
        worldLayer = Layer()
        
        // Gets the info from the GameConstants file in Template Folder
        worldLayer.zPosition = GameConstants.ZPositions.worldZ
        
        addChild(worldLayer)
        // only move x as player moves right not up
        worldLayer.layerVelocity = CGPoint(x: -200, y: 0.0)
        
        backgroundLayer = RepeatingLayer()
        
        // Gets the info from the GameConstants file in Template Folder
        backgroundLayer.zPosition = GameConstants.ZPositions.farBGZ
        
        addChild(backgroundLayer)
        
        // this will run twice for the background so it can repeat
        for i in 0...1 {
            let backgroundImage = SKSpriteNode(imageNamed: GameConstants.StringConstants.worldBackgroundNames[0])
            backgroundImage.name = String(i)
            // scale the background image
            backgroundImage.scale(to: frame.size, width: false, multiplier: 1.0)
            backgroundImage.anchorPoint = CGPoint.zero
            backgroundImage.position = CGPoint(x: 0.0 + CGFloat(i) * backgroundImage.size.width, y: 0.0)
            backgroundLayer.addChild(backgroundImage)
        }
        
        // half the speed of the world layer, more realistic, dimentional
        backgroundLayer.layerVelocity = CGPoint(x: -100, y: 0.0)
        
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
        if let groundTiles = mapNode.childNode(withName: GameConstants.StringConstants.groundTilesName) as? SKTileMapNode {
            tileMap = groundTiles
            // set to entire size of the frame, width is false because it is ongoing
            tileMap.scale(to: frame.size, width: false, multiplier: 1.0)
            
        }
        
        addPlayer()
    }
    
    // called above in loadTileMap
    func addPlayer() {
        // Getting this from the Game Constants file
        player = Player(imageNamed: GameConstants.StringConstants.playerImageName)
        // 0.1 is a tenth of the screen for the size of the chinchilla
        player.scale(to: frame.size, width: false, multiplier: 0.1)
        player.name = GameConstants.StringConstants.playerName
        // Position for the chinchilla is in first quarter of screen, and middle of y axis
        player.position = CGPoint(x: frame.midX/2.0, y: frame.midY)
        player.zPosition = GameConstants.ZPositions.playerZ
        // add the chinchilla to the game
        addChild(player)
        
    }
    
    // User controls player starting, jumping, moving etc by touch therefore these override functions are needed
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch gameState {
        case .ready:
            gameState = .ongoing
        default:
            break
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
    
        if lastTime > 0 {
            dt = currentTime - lastTime
        } else {
            dt = 0
        }
        lastTime = currentTime
        
        
        if gameState == .ongoing {
            worldLayer.update(dt)
            backgroundLayer.update(dt)
        }
        
    }
}
