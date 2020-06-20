//
//  GameSceneL2W3.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 20/06/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import SpriteKit

enum XmasGameStateL2 {
    case ready, ongoing, paused, finished
}

class GameSceneL2W3: SKScene {
    
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
    
    var brake = false
    
    var fruits = 0
    
    var superFruits = 0
    
    var popup: PopupNode?
    
    let soundPlayer = SoundPlayer()
    
   
    var levelKey: String
 
    
    var hudDelegate: HUDDelegate?
    
    var sceneManagerDelegateXmasL2: SceneManagerDelegateXmasL2?
    
    init(size: CGSize, sceneManagerDelegateXmasL2: SceneManagerDelegateXmasL2) {
     
        self.levelKey = "Level_2-2"
        self.sceneManagerDelegateXmasL2 = sceneManagerDelegateXmasL2
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -6.0)
        
        physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: frame.minX, y: frame.minY), to: CGPoint(x: frame.maxX, y: frame.minY))
        physicsBody!.categoryBitMask = GameConstants.PhysicsCategories.frameCategory
        physicsBody!.contactTestBitMask = GameConstants.PhysicsCategories.playerCategory
        
        createLayers()
        
        isPaused = true
        isPaused = false
        
    }
    
    
    func createLayers() {
        worldLayer = Layer()
        
        worldLayer.zPosition = GameConstants.ZPositions.worldZ
        
        addChild(worldLayer)
        
        worldLayer.layerVelocity = CGPoint(x: -200, y: 0.0)
        
        backgroundLayer = RepeatingLayer()
        
        
        backgroundLayer.zPosition = GameConstants.ZPositions.farBGZ
        
        addChild(backgroundLayer)
        
        for i in 0...1 {
            let backgroundImage = SKSpriteNode(imageNamed: GameConstants.StringConstants.world3BackgroundName)
            backgroundImage.name = String(i)
            backgroundImage.scale(to: frame.size, width: false, multiplier: 1.0)
            backgroundImage.anchorPoint = CGPoint.zero
            backgroundImage.position = CGPoint(x: 0.0 + CGFloat(i) * backgroundImage.size.width, y: 0.0)
            backgroundLayer.addChild(backgroundImage)
        }
        
        
        backgroundLayer.layerVelocity = CGPoint(x: -100, y: 0.0)
        
        load(level: "Level_2-2")
    }
    
    func load(level: String) {
        if let levelNode = SKNode.unarchiveFromFile(file: level) {
            mapNode = levelNode
            
            worldLayer.addChild(mapNode)
            loadTileMap()
        }
    }
    
    func loadTileMap() {
        
        if let groundTiles = mapNode.childNode(withName: GameConstants.StringConstants.groundTilesName) as? SKTileMapNode {
            tileMap = groundTiles
            
            tileMap.scale(to: frame.size, width: false, multiplier: 1.0)
            
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
    
    
    func addPlayer() {
        
        player = Player(imageNamed: GameConstants.StringConstants.playerImageName)
        
        player.scale(to: frame.size, width: false, multiplier: 0.1)
        player.name = GameConstants.StringConstants.playerName
        
        PhysicsHelper.addPhysicsBody(to: player, with: player.name!)
        
        player.position = CGPoint(x: frame.midX/2.0, y: frame.midY)
        player.zPosition = GameConstants.ZPositions.playerZ
        
        player.loadTextures()
        player.state = .idle
        
        addChild(player)
        
        addPlayerActions()
        
    }
    
    func addPlayerActions() {
    
        let up = SKAction.moveBy(x: 0.0, y: frame.size.height/4, duration: 0.4)
        
        up.timingMode = .easeOut
        
        player.createUserData(entry: up, forKey: GameConstants.StringConstants.jumpUpActionKey)
        
        let move = SKAction.moveBy(x: 0.0, y: player.size.height, duration: 0.4)
        
        
        let jump = SKAction.animate(with: player.jumpFrames, timePerFrame: 0.4/Double(player.jumpFrames.count))
        let group = SKAction.group([move,jump])
        
        player.createUserData(entry: group, forKey: GameConstants.StringConstants.brakeDescendActionKey)
        
    }
    
    
    
    func jump() {
        
        player.airborne = true
        
        player.turnGravity(on: false)
        player.run(player.userData?.value(forKey: GameConstants.StringConstants.jumpUpActionKey) as! SKAction) {
            
            if self.touch {
                self.player.run(self.player.userData?.value(forKey: GameConstants.StringConstants.jumpUpActionKey) as! SKAction) {
                    
                    self.player.turnGravity(on: true)
                }
            }
        }
    }
    
    func brakeDecend() {
        brake = true
        
        player.physicsBody!.velocity.dy = 0.0
        
        
        if let sparky = ParticleHelper.addParticleEffect(name: GameConstants.StringConstants.brakeSparkEmitterKey, particlePositionRange: CGVector(dx: 30.0, dy: 30.0), position: CGPoint(x: player.position.x, y: player.position.y - player.size.height/2)) {
            sparky.zPosition = GameConstants.ZPositions.objectZ
            addChild(sparky)
        }
        
        player.run(player.userData?.value(forKey: GameConstants.StringConstants.brakeDescendActionKey) as! SKAction) {
            
            
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
    
    
    func collectFruit(sprite: SKSpriteNode) {
        
        
        if GameConstants.StringConstants.superFruitNames.contains(sprite.name!) {
            superFruits += 1
            for index in 0..<3 {
                if GameConstants.StringConstants.superFruitNames[index] == sprite.name! {
                    hudDelegate?.addSuperFruit(index: index)
                }
            }
        } else {
            fruits += 1
            
            hudDelegate?.updateFruitLabel(fruits: fruits)
        }
        
        
        if let fruitDust = ParticleHelper.addParticleEffect(name: GameConstants.StringConstants.fruitDustEmitterKey, particlePositionRange: CGVector(dx: 5.0, dy: 5.0), position: CGPoint.zero) {
            fruitDust.zPosition = GameConstants.ZPositions.objectZ
            sprite.addChild(fruitDust)
            sprite.run(SKAction.fadeOut(withDuration: 0.4), completion: {
                
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
            
            
            popup = PopupNode(withTitle: title, and: SKTexture(imageNamed: GameConstants.StringConstants.smallPopup), buttonHandlerDelegate: self)
            popup!.add(buttons: [0,3,2])
            
        default:
            
            
            popup = ScorePopupNode(buttonHandlerDelegate: self, title: title, level: "Level_2-2", texture: SKTexture(imageNamed: GameConstants.StringConstants.largePopup), score: fruits, fruits: superFruits, animated: true)
            popup!.add(buttons: [2,0])
        }
        
        popup!.position = CGPoint(x: frame.midX, y: frame.midY)
        popup!.zPosition = GameConstants.ZPositions.hudZ
        popup!.scale(to: frame.size, width: true, multiplier: 0.8)
        
        addChild(popup!)
    }
    
    func die(reason: Int) {
        run(soundPlayer.dieSound)
        gameState = .finished
        player.turnGravity(on: false)
        
        let deathAnimation: SKAction!
        
        
        switch reason {
        case 0:
            deathAnimation = SKAction.animate(with: player.dieFrames, timePerFrame: 0.1, resize: true, restore: true)
        case 1:
            
            let up = SKAction.moveTo(y: frame.midY, duration: 0.25)
            let wait = SKAction.wait(forDuration: 0.1)
            let down = SKAction.moveTo(y: -player.size.height, duration: 0.2)
            
            deathAnimation = SKAction.sequence([up, wait, down])
        default:
            deathAnimation = SKAction.animate(with: player.dieFrames, timePerFrame: 0.1, resize: true, restore: true)
        }
        
        player.run(deathAnimation) {
            
            self.player.removeFromParent()
            
            
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
        
        ScoreManager.compare(scores: [scores], in: "Level_2-2")
        createAndShowPopup(type: 1, title: GameConstants.StringConstants.completedKey)
    }
    
    
    
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
    
    
    
    override func didSimulatePhysics() {
        for node in tileMap[GameConstants.StringConstants.groundNodeName] {
            if let groundNode = node as? GroundNode {
                
                let groundY = (groundNode.position.y + groundNode.size.height) * tileMap.yScale
                
                let playerY = player.position.y - player.size.height/3
                
                
                groundNode.isBodyActivated = playerY > groundY
            }
        }
    }
    
    
    
}


extension GameSceneL2W3: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch contactMask {
            
        case GameConstants.PhysicsCategories.playerCategory | GameConstants.PhysicsCategories.groundCategory:
            player.airborne = false
            brake = false
            
        case GameConstants.PhysicsCategories.playerCategory | GameConstants.PhysicsCategories.finishCategory:
            
            finishGame()
            
        case GameConstants.PhysicsCategories.playerCategory | GameConstants.PhysicsCategories.enemyCategory:
            handleEnemyContact()
            
            
        case GameConstants.PhysicsCategories.playerCategory | GameConstants.PhysicsCategories.frameCategory:
            physicsBody = nil
            die(reason: 1)
            
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
            
        case GameConstants.PhysicsCategories.playerCategory | GameConstants.PhysicsCategories.groundCategory:
            player.airborne = true
        default:
            break
        }
    }
    
}

extension GameSceneL2W3: PopupButtonHandlerDelegate {
    
    func popupButtonHandler(index: Int) {
        
        switch index {
            
        case 0:
            popup!.run(SKAction.fadeOut(withDuration: 0.2)) {
                self.popup!.removeFromParent()
                
                self.sceneManagerDelegateXmasL2?.presentMenuViewController()
                
            }
            
            
            
        case 1:
            break
            
            
            
            
            
        case 2:
            
            popup!.run(SKAction.fadeOut(withDuration: 0.2)) {
                self.popup!.removeFromParent()
                
                self.sceneManagerDelegateXmasL2?.presentW3L2Scene()
                
                
            }
            
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
