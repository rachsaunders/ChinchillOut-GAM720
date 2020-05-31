//
//  PopupNode.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 16/05/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import SpriteKit

class PopupNode: SKSpriteNode {

    var buttonHandlerDelegate: PopupButtonHandlerDelegate
    
    init(withTitle title: String, and texture: SKTexture, buttonHandlerDelegate: PopupButtonHandlerDelegate) {
        
        self.buttonHandlerDelegate = buttonHandlerDelegate
        
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        let bannerLabel = BannerLabel(withTitle: title)
        // makes banner wider than the pop up width
        // Changing the below changes the size of both the banner and banner text
        bannerLabel.scale(to: size, width: true, multiplier: 1.1)
        // ERROR FIX - BANNER APPEARED BEHIND POPUP BEFORE THIS LINE WAS ADDED BELOW
        bannerLabel.zPosition = GameConstants.ZPositions.hudZ
         bannerLabel.position = CGPoint(x: frame.midX, y: frame.maxY)
        
        addChild(bannerLabel)
    }
    
    // The array of buttons is in GameConstants
    
    func add(buttons: [Int]) {
        let scalar = 1.0/CGFloat(buttons.count-1)
        for (index,button) in buttons.enumerated() {
            let buttonToAdd = SpriteKitButton(defaultButtonImage: GameConstants.StringConstants.popupButtonNames[button], action: buttonHandlerDelegate.popupButtonHandler, index: button)
            buttonToAdd.position = CGPoint(x: -frame.maxX/2 + CGFloat(index) * scalar * (frame.size.width*0.5), y: frame.minY)
            buttonToAdd.zPosition = GameConstants.ZPositions.hudZ
            buttonToAdd.scale(to: frame.size, width: true, multiplier: 0.25)
            addChild(buttonToAdd)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
