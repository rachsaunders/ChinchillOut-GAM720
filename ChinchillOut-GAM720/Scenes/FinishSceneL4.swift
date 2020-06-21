//
//  FinishSceneL4.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 21/06/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import SpriteKit
import ARKit
import UIKit

class FinishSceneL4: SKScene {
    

    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {return}
        let positionInScene = touch.location(in: self)
        let touchedNodes = self.nodes(at: positionInScene)
        
        if let name = touchedNodes.last?.name {
           
            
            if name == "afterArButton" {
              
                goToHalloweenWorldSegue()
                
                }
            }
        }
        
    }
    
extension FinishSceneL4: SceneManagerDelegateL4 {
 
    func goToHalloweenWorldSegue() {
       
    }
        
    }
    



