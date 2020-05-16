//
//  SpriteKitButton.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 16/05/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import SpriteKit

class SpriteKitButton: SKSpriteNode {

    var defaultButton: SKSpriteNode
    var action: (Int) -> ()
    var index: Int
    
    init(defaultButtonImage: String, action: @escaping (Int) -> (), index: Int) {
        defaultButton = SKSpriteNode(imageNamed: defaultButtonImage)
        self.action = action
        self.index = index
        
        super.init(texture: nil, color: UIColor.clear, size: defaultButton.size)
        
        // To interact with the buttons
        isUserInteractionEnabled = true
        // Make button visable
        addChild(defaultButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        defaultButton.alpha = 0.75
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch: UITouch = touches.first! as UITouch
        let location: CGPoint = touch.location(in: self)
        
        if defaultButton.contains(location) {
             // button transparency
            defaultButton.alpha = 0.75
        } else {
            defaultButton.alpha = 1
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch: UITouch = touches.first! as UITouch
        let location: CGPoint = touch.location(in: self)
        
        if defaultButton.contains(location) {
            action(index)
        }
         // resets button transparency
        defaultButton.alpha = 1.0
        
        
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        // resets button transparency
        defaultButton.alpha = 1.0
    }
    
    
    
}
