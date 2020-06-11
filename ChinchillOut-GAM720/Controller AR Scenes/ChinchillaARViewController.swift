//
//  ChinchillaARViewController.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 11/06/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import UIKit
import ARKit

class ChinchillaARViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
           super.viewDidLoad()

           // Show statistics such as fps and timing information
           sceneView.showsStatistics = true
           
           // see where the model is
           sceneView.debugOptions = ARSCNDebugOptions.showWorldOrigin
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
}
