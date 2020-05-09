//
//  RepeatingLayer.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 09/05/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import SpriteKit

class RepeatingLayer: Layer {
    
    // check whether childnode has moved so far to the left it is no longer visable, if so reposition it to the right next to it aka scrolling background
    override func updateNodes(_ delta: TimeInterval, childNode: SKNode) {
        if let node = childNode as? SKSpriteNode {
            if node.position.x <= -(node.size.width) {
                if node.name == "0" && self.childNode(withName: "1") != nil || node.name == "1" && self.childNode(withName: "0") != nil {
                    // move image double its width right, because it uses two images
                    node.position = CGPoint(x: node.position.x + node.size.width*2, y: node.position.y)
                }
            }
        }
    }
    
}
