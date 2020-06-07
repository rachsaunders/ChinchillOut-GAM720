//
//  SKNode+Extensions.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 08/05/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//
//
import SpriteKit

extension SKNode {
    
    // Load the tile Map - Level_0-1.sks
    class func unarchiveFromFile(file: String) -> SKNode? {
        if let path = Bundle.main.path(forResource: file, ofType: "sks") {
            let url = URL(fileURLWithPath: path)
            do {
                let sceneData = try Data(contentsOf: url, options: .mappedIfSafe)
                let archiver = NSKeyedUnarchiver(forReadingWith: sceneData)
                archiver.setClass(self.classForKeyedArchiver(), forClassName: "SKScene")
                let scene = archiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as! SKNode
                    archiver.finishDecoding()
                return scene
            } catch {
                print(error.localizedDescription)
                return nil
            }
        } else {
            return nil
        }
    }
    
    // use either width or height to scale sknodes depending on other node sizes
    func scale(to screenSize: CGSize, width: Bool, multiplier: CGFloat) {

        // takes width of object used for reference and multiplies by the multiplier, divided by the width of the node that is trying to scale
        // takes height of object used for reference and multiplies by the multiplier, divided by the height of the node that is trying to scale

        let scale = width ? (screenSize.width * multiplier) / self.frame.size.width : (screenSize.height * multiplier) / self.frame.size.height
        
        self.setScale(scale)
        
    }
    
    // gravity physics properties
    func turnGravity(on value: Bool) {
        physicsBody?.affectedByGravity = value
    }
    
    func createUserData(entry: Any, forKey key: String) {
        // if it doesn't exist
        if userData == nil {
            // create a new dictionary
            let userDataDictionary = NSMutableDictionary()
            userData = userDataDictionary
        }
        
        // Use the dictionary
        userData!.setValue(entry, forKey: key)
    }
    
}
