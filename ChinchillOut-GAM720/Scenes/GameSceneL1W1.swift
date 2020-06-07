//
//  GameSceneL1W1.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 08/05/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//
//
import SpriteKit

enum GameState {
    case ready, ongoing, paused, finished
}

class GameSceneL1W1: SKScene {
    
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
            case .paused:
                player.state = .idle
                pauseEnemies(bool: true)
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
    
    // count collected fruit
    var fruits = 0
    
    var superFruits = 0
    
    var popup: PopupNode?
    
    let soundPlayer = SoundPlayer()
    
    /////////////
    var levelKey: String
    //////////////
    
    var hudDelegate: HUDDelegate?
    
    
    
    // TESTING OUT THE BELOW !
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    var sceneManagerDelegate: SceneManagerDelegate?
    
    init(size: CGSize, sceneManagerDelegate: SceneManagerDelegate) {
        //             self.world = world
        //             self.level = level
        self.levelKey = "Level_0-1"
        self.sceneManagerDelegate = sceneManagerDelegate
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
            let backgroundImage = SKSpriteNode(imageNamed: GameConstants.StringConstants.world1BackgroundName)
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
        
        addHUD()
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
        
        // spark animation
        if let sparky = ParticleHelper.addParticleEffect(name: GameConstants.StringConstants.brakeSparkEmitterKey, particlePositionRange: CGVector(dx: 30.0, dy: 30.0), position: CGPoint(x: player.position.x, y: player.position.y - player.size.height/2)) {
            sparky.zPosition = GameConstants.ZPositions.objectZ
            addChild(sparky)
        }
        
        player.run(player.userData?.value(forKey: GameConstants.StringConstants.brakeDescendActionKey) as! SKAction) {
            
            // remove particle affect
            ParticleHelper.removeParticleEffect(name: GameConstants.StringConstants.brakeSparkEmitterKey, from: self)
        }
    }
    
    func handleEnemyContact() {
        die(reason: 0)
    }
    
    func pauseEnemies(bool: Bool) {
        for enemy in tileMap[GameConstants.StringConstants.enemyName] {
            enemy.isPaused = bool
        }
    }
    
    // FOR ALL COLLETABLES
    func handleCollectable(sprite: SKSpriteNode) {
        switch sprite.name! {
        case GameConstants.StringConstants.fruitName,
             _ where GameConstants.StringConstants.superFruitNames.contains(sprite.name!):
            run(soundPlayer.fruitSound)
            collectFruit(sprite: sprite)
        default:
            break
        }
        
    }
    
    // FOR FRUIT ONLY
    func collectFruit(sprite: SKSpriteNode) {
        
        // tell the difference between SuperFruit and Fruit
        if GameConstants.StringConstants.superFruitNames.contains(sprite.name!) {
            superFruits += 1
            for index in 0..<3 {
                if GameConstants.StringConstants.superFruitNames[index] == sprite.name! {
                    hudDelegate?.addSuperFruit(index: index)
                }
            }
        } else {
            fruits += 1
            // update
            hudDelegate?.updateFruitLabel(fruits: fruits)
        }
        
        
        if let fruitDust = ParticleHelper.addParticleEffect(name: GameConstants.StringConstants.fruitDustEmitterKey, particlePositionRange: CGVector(dx: 5.0, dy: 5.0), position: CGPoint.zero) {
            fruitDust.zPosition = GameConstants.ZPositions.objectZ
            sprite.addChild(fruitDust)
            sprite.run(SKAction.fadeOut(withDuration: 0.4), completion: {
                // remove effect and the fruit
                fruitDust.removeFromParent()
                sprite.removeFromParent()
            })
            
        }
    }
    
    func buttonHandler(index: Int) {
        if gameState == .ongoing {
            gameState = .paused
            createAndShowPopup(type: 0, title: GameConstants.StringConstants.pausedKey)
        }
    }
    
    
    func addHUD() {
        let hud = GameHUD(with: CGSize(width: frame.width, height: frame.height*0.1))
        hud.position = CGPoint(x: frame.midX, y: frame.maxY - frame.height*0.05)
        hud.zPosition = GameConstants.ZPositions.hudZ
        hudDelegate = hud
        addChild(hud)
        
        let pauseButton = SpriteKitButton(defaultButtonImage: GameConstants.StringConstants.pauseButton, action: buttonHandler, index: 0)
        pauseButton.scale(to: frame.size, width: false, multiplier: 0.1)
        pauseButton.position = CGPoint(x: frame.midX, y: frame.maxY - pauseButton.size.height/1.9)
        pauseButton.zPosition = GameConstants.ZPositions.hudZ
        
        addChild(pauseButton)
    }
    
    func createAndShowPopup(type: Int, title: String) {
        switch type {
        case 0:
            
            // PAUSED
            popup = PopupNode(withTitle: title, and: SKTexture(imageNamed: GameConstants.StringConstants.smallPopup), buttonHandlerDelegate: self)
            popup!.add(buttons: [0,3,2])
            
        default:
            
            // FAILED, COMPLETED
            popup = ScorePopupNode(buttonHandlerDelegate: self, title: title, level: "Level_0-1", texture: SKTexture(imageNamed: GameConstants.StringConstants.largePopup), score: fruits, fruits: superFruits, animated: true)
            popup!.add(buttons: [2,0])
        }
        
        popup!.position = CGPoint(x: frame.midX, y: frame.midY)
        popup!.zPosition = GameConstants.ZPositions.hudZ
        popup!.scale(to: frame.size, width: true, multiplier: 0.8)
        
        addChild(popup!)
    }
    
    
    // two ways player can die - obstacle or falling off the edge
    func die(reason: Int) {
        run(soundPlayer.dieSound)
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
            
            // pop up
            self.createAndShowPopup(type: 1, title: GameConstants.StringConstants.failedKey)
        }
    }
    
    func finishGame() {
        run(soundPlayer.completedSound)
        gameState = .finished
        var stars = 0
        let percentage = CGFloat(fruits)/100.0
        
        if percentage >= 0.8 {
            stars = 3
        } else if percentage >= 0.4 {
            stars = 2
        } else if fruits >= 1 {
            stars = 1
        }
        let scores = [
            
            GameConstants.StringConstants.scoreScoreKey: fruits,
            GameConstants.StringConstants.scoreStarsKey: stars,
            GameConstants.StringConstants.scoreFruitsKey: superFruits
            
            
        ]
        
        ScoreManager.compare(scores: [scores], in: "Level_0-1")
        createAndShowPopup(type: 1, title: GameConstants.StringConstants.completedKey)
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
extension GameSceneL1W1: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch contactMask {
        // contact between chinchilla and ground aka chinchilla landed on the ground
        case GameConstants.PhysicsCategories.playerCategory | GameConstants.PhysicsCategories.groundCategory:
            player.airborne = false
            brake = false
            
        case GameConstants.PhysicsCategories.playerCategory | GameConstants.PhysicsCategories.finishCategory:
            // gameState = .finished
            finishGame()
            
        case GameConstants.PhysicsCategories.playerCategory | GameConstants.PhysicsCategories.enemyCategory:
            handleEnemyContact()
            
        // Falling off the ledge
        case GameConstants.PhysicsCategories.playerCategory | GameConstants.PhysicsCategories.frameCategory:
            physicsBody = nil
            die(reason: 1)
            
        // Collectables
        case GameConstants.PhysicsCategories.playerCategory | GameConstants.PhysicsCategories.collectibleCategory:
            let collectible = contact.bodyA.node?.name == player.name ? contact.bodyB.node as! SKSpriteNode : contact.bodyA.node as! SKSpriteNode
            handleCollectable(sprite: collectible)
            
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

extension GameSceneL1W1: PopupButtonHandlerDelegate {
    
    func popupButtonHandler(index: Int) {
        
        switch index {
        // Menu
        case 0:
            popup!.run(SKAction.fadeOut(withDuration: 0.2)) {
                self.popup!.removeFromParent()
                
                self.sceneManagerDelegate?.presentMenuViewController()
                
            }
            
            
            // // // // // // // // // // // // //
            
            // Play
        // Only needed on the Level Selection
        case 1:
            break
            
            // // // // // // // // // // // // //
            
            
        // Retry
        case 2:
            
            popup!.run(SKAction.fadeOut(withDuration: 0.2)) {
                self.popup!.removeFromParent()
                
                self.sceneManagerDelegate?.presentW1L1Scene()
                // just an idea below
                // self.presentGameSceneL1W1()
                
            }
        // Cancel
        case 3:
            popup!.run(SKAction.fadeOut(withDuration: 0.2)) {
                self.popup!.removeFromParent()
                self.gameState = .ongoing
            }
        default:
            break
        }
        
    }
    
}
