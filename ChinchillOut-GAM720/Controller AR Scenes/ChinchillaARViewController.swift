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
          
            }
            
            override func viewWillAppear(_ animated: Bool) {
                super.viewWillAppear(animated)
                setUpSceneView()
            }
            
            override func viewWillDisappear(_ animated: Bool) {
                super.viewWillDisappear(animated)
                sceneView.session.pause()
            }
            
    
            func setUpSceneView() {
               
                let configuration = ARWorldTrackingConfiguration()
                
                  configuration.planeDetection = .horizontal
                  
                  sceneView.session.run(configuration)
                  
                  sceneView.delegate = self
                
                  sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
            }
            
            func configureLighting() {
                sceneView.autoenablesDefaultLighting = true
                sceneView.automaticallyUpdatesLighting = true
            }
            
        }

        extension float4x4 {
            var translation: SIMD3<Float> {
                let translation = self.columns.3
                return SIMD3<Float>(translation.x, translation.y, translation.z)
            }
        }

        extension UIColor {
            open class var transparentLightBlue: UIColor {
                return UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 0.50)
            }
        }



    extension ChinchillaARViewController: ARSCNViewDelegate {

     
     func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
         // 1
         guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
         
         // 2
         let width = CGFloat(planeAnchor.extent.x)
         let height = CGFloat(planeAnchor.extent.z)
         let plane = SCNPlane(width: width, height: height)
         
         // 3
         plane.materials.first?.diffuse.contents = UIColor.transparentLightBlue
         
         // 4
         let planeNode = SCNNode(geometry: plane)
         
         // 5
         let x = CGFloat(planeAnchor.center.x)
         let y = CGFloat(planeAnchor.center.y)
         let z = CGFloat(planeAnchor.center.z)
         planeNode.position = SCNVector3(x,y,z)
         planeNode.eulerAngles.x = -.pi / 2
         
         // 6
         node.addChildNode(planeNode)
     }
        
    }

