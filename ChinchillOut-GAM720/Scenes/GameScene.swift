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
    
    var gameState = GameState.ready {
        willSet {
            switch newValue {
            case .ongoing:
                player.state = .running
                pauseEnemies(bool: false)
            case .finished:
                player.state = .idle
                pauseEnemies(bool: true)
            default:
                break
            }
        }
    }
    
    
    var player: Player!
    
    var touch = false
    // help the double jump
    var brake = false
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        // x is 0 as gravity isnt needed left and right, just downwards aka y axis
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -6.0)
        
        // Supports the chinchilla dying when not on a ledge
        physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: frame.minX, y: frame.minY), to: CGPoint(x: frame.maxX, y: frame.minY))
        physicsBody!.categoryBitMask = GameConstants.PhysicsCategories.frameCategory
        physicsBody!.contactTestBitMask = GameConstants.PhysicsCategories.playerCategory
        
        createLayers()
        
        // ADDED TO FIX A BUG ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        isPaused = true
        isPaused = false
        
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
            // from physics helper file, ground is named on the tileSet file for ground tiles
            PhysicsHelper.addPhysicsBody(to: tileMap, and: "ground")
            
            for child in groundTiles.children {
                if let sprite = child as? SKSpriteNode, sprite.name != nil {
                   
                    ObjectHelper.handleChild(sprite: sprite, with: sprite.name!)
                }
            }
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
        // add physics body properties to chinchilla
        PhysicsHelper.addPhysicsBody(to: player, with: player.name!)
        // Position for the chinchilla is in first quarter of screen, and middle of y axis
        player.position = CGPoint(x: frame.midX/2.0, y: frame.midY)
        player.zPosition = GameConstants.ZPositions.playerZ
        // load frames
        player.loadTextures()
        player.state = .idle
        // add the chinchilla to the game
        addChild(player)
        
        addPlayerActions()
        
    }
    
    func addPlayerActions() {
        // y is dependant on screen height, quaeter of screen size
        let up = SKAction.moveBy(x: 0.0, y: frame.size.height/4, duration: 0.4)
        // slows down action at the end like after jumping
        up.timingMode = .easeOut
        
        player.createUserData(entry: up, forKey: GameConstants.StringConstants.jumpUpActionKey)
        // for the double jump
        let move = SKAction.moveBy(x: 0.0, y: player.size.height, duration: 0.4)
        
        // IF THIS LOOKS BAD ADD resize: <#T##Bool#>, restore: <#T##Bool#> at the end of the bracket below
        let jump = SKAction.animate(with: player.jumpFrames, timePerFrame: 0.4/Double(player.jumpFrames.count))
        let group = SKAction.group([move,jump])
        
        player.createUserData(entry: group, forKey: GameConstants.StringConstants.brakeDescendActionKey)
        
    }
    
    
    
    func jump() {
        // stops double jump issue
        player.airborne = true
        // turn off gravity when chinchilla jumps
        player.turnGravity(on: false)
        player.run(player.userData?.value(forKey: GameConstants.StringConstants.jumpUpActionKey) as! SKAction) {
        
            if self.touch {
                self.player.run(self.player.userData?.value(forKey: GameConstants.StringConstants.jumpUpActionKey) as! SKAction) {
                    // chinchilla gravity back on
                    self.player.turnGravity(on: true)
                }
            }
        }
    }
    
    func brakeDecend() {
        brake = true
        // speed in y direction for braking
        player.physicsBody!.velocity.dy = 0.0
        
        player.run(player.userData?.value(forKey: GameConstants.StringConstants.brakeDescendActionKey) as! SKAction)
    }
    
    func handleEnemyContact() {
        die(reason: 0)
    }
    
    func pauseEnemies(bool: Bool) {
        for enemy in tileMap[GameConstants.StringConstants.enemyName] {
            enemy.isPaused = bool
        }
    }
    
    // two ways player can die - obstacle or falling off the edge
    func die(reason: Int) {
        gameState = .finished
        player.turnGravity(on: false)
        
        let deathAnimation: SKAction!
        
        // Case 0 is contact with a still enemy, case 2 is falling off the level
        switch reason {
        case 0:
            deathAnimation = SKAction.animate(with: player.dieFrames, timePerFrame: 0.1, resize: true, restore: true)
        case 1:
        // when falling off a ledge chinchilla will move a bit upwards for die animation
            let up = SKAction.moveTo(y: frame.midY, duration: 0.25)
            let wait = SKAction.wait(forDuration: 0.1)
            let down = SKAction.moveTo(y: -player.size.height, duration: 0.2)
            // combine the above for the death animation when falling off a ledge
            deathAnimation = SKAction.sequence([up, wait, down])
        default:
            deathAnimation = SKAction.animate(with: player.dieFrames, timePerFrame: 0.1, resize: true, restore: true)
        }
        
        player.run(deathAnimation) {
            // remove player sprite from screen when dead
            self.player.removeFromParent()
        }
    }
    
    // User controls player starting, jumping, moving etc by touch therefore these override functions are needed
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         switch gameState {
         case .ready:
             gameState = .ongoing
         case .ongoing:
            touch = true
             if !player.airborne {
                 jump()
             } else if !brake {
                brakeDecend()
            }
         default:
             break
         }
     }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touch = false
        player.turnGravity(on: true)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touch = false
        player.turnGravity(on: true)
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
    
    // physics of ground nodes. override didsimulatephysics
    
    override func didSimulatePhysics() {
        for node in tileMap[GameConstants.StringConstants.groundNodeName] {
            if let groundNode = node as? GroundNode {
                // top edge of ground node
                let groundY = (groundNode.position.y + groundNode.size.height) * tileMap.yScale
                
                let playerY = player.position.y - player.size.height/3
                
                // if y position of chinchilla is bigger or higher than y position of ground node, physics body is activated aka can stand on it
                groundNode.isBodyActivated = playerY > groundY
            }
        }
    }
    
    
    
}

// Added when physics bodies come into contact
extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch contactMask {
        // contact between chinchilla and ground aka chinchilla landed on the ground
        case GameConstants.PhysicsCategories.playerCategory | GameConstants.PhysicsCategories.groundCategory:
            player.airborne = false
            brake = false
            
        case GameConstants.PhysicsCategories.playerCategory | GameConstants.PhysicsCategories.finishCategory:
            gameState = .finished
            
        case GameConstants.PhysicsCategories.playerCategory | GameConstants.PhysicsCategories.enemyCategory:
            handleEnemyContact()
            // Falling off the ledge
        case GameConstants.PhysicsCategories.playerCategory | GameConstants.PhysicsCategories.frameCategory:
            physicsBody = nil
            die(reason: 1)
            
        default:
            break
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
         let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch contactMask {
            // contact between chinchilla and ground aka chinchilla fell off the edge
        case GameConstants.PhysicsCategories.playerCategory | GameConstants.PhysicsCategories.groundCategory:
            player.airborne = true
        default:
            break
        }
    }
}
