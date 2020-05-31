//
//  BannerLabel.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 16/05/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import SpriteKit

class BannerLabel: SKSpriteNode {
    
    init(withTitle title: String) {
        
        let texture = SKTexture(imageNamed: GameConstants.StringConstants.bannerName)
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        let label = SKLabelNode(fontNamed: GameConstants.StringConstants.gameFontName)

        label.fontSize = 100.0
        label.fontColor = UIColor.blue
        label.verticalAlignmentMode = .center
        label.text = title
        label.scale(to: CGSize(width: 400, height: 500), width: false, multiplier: 0.5)
        // THE BELOW MAKES IT APPEAR TERRIBLE ON SCREEN SO IT HAS BEEN REWRITTEN ABOVE!
      //  label.scale(to: size, width: false, multiplier: 0.3)
        label.zPosition = GameConstants.ZPositions.hudZ
        
        addChild(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
