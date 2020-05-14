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
            let component = name.components(separatedBy: NSCharacterSet.decimalDigits.inverted)
            if let rows = Int(component[0]), let columns = Int(component[1]) {
                // red sprite box on map is the parent
                calculateGridWidth(rows: rows, columns: columns, parent: sprite)
            }
        }
        
    }
    
    // Grid of fruit
    static func calculateGridWidth(rows: Int, columns: Int, parent: SKSpriteNode) {
        // Hides the red box
        parent.color = UIColor.clear
        for x in 0..<columns {
            for y in 0..<rows {
                let position = CGPoint(x: x, y: y)
                addFruit(to: parent, at: position, columns: columns)
            }
        }
    }
    
    // Adding fruit
    static func addFruit(to parent: SKSpriteNode, at position: CGPoint, columns: Int) {
        // TO CHECK IT WORKS
       // print("add coin to \(parent.name!) at \(position)")
        let fruit = SKSpriteNode(imageNamed: GameConstants.StringConstants.fruitImageName)
        fruit.size = CGSize(width: parent.size.width/CGFloat(columns), height: parent.size.width/CGFloat(columns))
        fruit.name = GameConstants.StringConstants.fruitName
        
 
        fruit.position = CGPoint(x: position.x * fruit.size.width + fruit.size.width/2, y: position.y * fruit.size.height + fruit.size.height/2)
        
        let fruitFrames = AnimationHelper.loadTextures(from: SKTextureAtlas(named: GameConstants.StringConstants.fruitRotateAtlas), withName: GameConstants.StringConstants.fruitPrefixKey)
        fruit.run(SKAction.repeatForever(SKAction.animate(with: fruitFrames, timePerFrame: 0.1)))
        
        PhysicsHelper.addPhysicsBody(to: fruit, with: GameConstants.StringConstants.fruitName)
        
        parent.addChild(fruit)
    }
    
}
