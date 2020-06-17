//
//  ChinchillaARModel.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 12/06/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import ARKit

class ChinchillaARModel: SCNNode {
    func loadModel() {
        guard let virtualObjectScene = SCNScene(named: "ChinchillaUpdate.scn") else { return }
        let wrapperNode = SCNNode()
        for child in virtualObjectScene.rootNode.childNodes {
            wrapperNode.addChildNode(child)
        }
        addChildNode(wrapperNode)
    }
}
