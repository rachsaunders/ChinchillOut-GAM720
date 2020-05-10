//
//  GroundNode.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 10/05/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import SpriteKit

class GroundNode: SKSpriteNode {
    
    var isBodyActivated: Bool = false {
        didSet {
            // if player is below platform remove physics property
            physicsBody = isBodyActivated ? activatedBody : nil
        }
    }
    
    private var activatedBody: SKPhysicsBody?
    
    init(with size: CGSize) {
        super.init(texture: nil, color: UIColor.clear, size: size)
        
        // left and right edges of platforms/ledges
        let bodyInitialPoint = CGPoint(x: 0.0, y: size.height)
        let bodyEndPoint = CGPoint(x: size.width, y: size.height)
       
        activatedBody = SKPhysicsBody(edgeFrom: bodyInitialPoint, to: bodyEndPoint)
        activatedBody!.restitution = 0.0
        
        physicsBody = isBodyActivated ? activatedBody : nil
        
        name = GameConstants.StringConstants.groundNodeName
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
