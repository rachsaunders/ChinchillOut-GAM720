//
//  GameHUD.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 15/05/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import SpriteKit

class GameHUD: SKSpriteNode, HUDDelegate {
    
    var fruitLabel: SKLabelNode
    var superFruitCounter: SKSpriteNode
    
    init(with size: CGSize) {
        fruitLabel = SKLabelNode(fontNamed: GameConstants.StringConstants.gameFontName)
        superFruitCounter = SKSpriteNode(texture: nil, color: UIColor.clear, size: CGSize(width: size.width*0.3, height: size.height*0.8))
        
        super.init(texture: nil, color: UIColor.clear, size: size)
        
        fruitLabel.verticalAlignmentMode = .center
        fruitLabel.text = "0"
        fruitLabel.fontSize = 200.0
        fruitLabel.scale(to: frame.size, width: false, multiplier: 0.8)
        fruitLabel.position = CGPoint(x: frame.maxX - fruitLabel.frame.size.width*2, y: frame.midY)
        fruitLabel.zPosition = GameConstants.ZPositions.hudZ
        addChild(fruitLabel)
        
        superFruitCounter.position = CGPoint(x: frame.minX + superFruitCounter.frame.size.width/2, y: frame.midY)
        superFruitCounter.zPosition = GameConstants.ZPositions.hudZ
        addChild(superFruitCounter)
        
        for i in 0..<3 {
            let emptySlot = SKSpriteNode(imageNamed: GameConstants.StringConstants.superFruitImageName)
            emptySlot.name = String(i)
            emptySlot.alpha = 0.5
            emptySlot.scale(to: superFruitCounter.size, width: true, multiplier: 0.3)
            // changed to fix error of position of the Super Fruit Counter
            emptySlot.position = CGPoint(x: -superFruitCounter.size.width/2 + emptySlot.size.width/2 + CGFloat(i)*superFruitCounter.size.width/3 + superFruitCounter.size.width*0.05, y: superFruitCounter.frame.midY)
            emptySlot.zPosition = GameConstants.ZPositions.hudZ
            superFruitCounter.addChild(emptySlot)
        }
        
    }
    
    // required for init - do not delete
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateFruitLabel(fruits: Int) {
        
        
    }
    
    func addSuperFruit(index: Int) {
        
        
    }
    
}
