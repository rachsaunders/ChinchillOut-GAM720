//
//  GameConstants.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 09/05/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import Foundation
import CoreGraphics

struct GameConstants {
    
    struct PhysicsCategories {
        // physics bodies with no content to check
        static let noCategory: UInt32 = 0
        static let allCategory: UInt32 = UInt32.max
        
        // Bit masks
        static let playerCategory: UInt32 = 0x1
        // shifts to left by 1, 1 0 in bit numbers
        static let groundCategory: UInt32 = 0x1 << 1
        // shifts to left by 2, 1 0 0 in bit numbers
        static let finishCategory: UInt32 = 0x1 << 2
          // shifts to left by 3, 1 0 0 0 in bit numbers
        static let collectibleCategory: UInt32 = 0x1 << 3
        static let enemyCategory: UInt32 = 0x1 << 4
        static let frameCategory: UInt32 = 0x1 << 5
        static let ceilingCategory: UInt32 = 0x1 << 6
    }
    
    // order of the layers e.g. Background is right at the back, player is more towards the front
    struct ZPositions {
           static let farBGZ: CGFloat = 0
           static let closeBGZ: CGFloat = 1
           static let worldZ: CGFloat = 2
           static let objectZ: CGFloat = 3
           static let playerZ: CGFloat = 4
           static let hudZ: CGFloat = 5
       }
    
    struct StringConstants {
        
        static let gameName = "ChinchillOut"
        
        static let groundTilesName = "Ground Tiles"
        static let worldBackgroundNames = ["ForestBackground", "GrassBackground"]
        
        static let playerName = "Player"
        static let playerImageName = "Idle_0"
        
        static let groundNodeName = "GroundNode"
        
        static let finishLineName = "FinishLine"
        
        static let enemyName = "Enemy"
        
        static let fruitName = "Fruit"
        static let fruitImageName = "rosehip0"
        
        static let superFruitImageName = "SuperRosehip"
        static let superFruitNames = ["SuperRosehip1","SuperRosehip2","SuperRosehip3"]
        
        static let gameFontName = "CHICKEN Pie"
        
        static let playButton = "PlayButton"
        static let resetButton = "ResetButton"
        static let menuButton = "MenuButton"
        static let pauseButton = "PauseButton"
        static let emptyButton = "EmptyButton"
        static let cancelButton = "CancelButton"
        
        static let largePopup = "PopupLarge"
        static let smallPopup = "PopupSmall"
        
        // Changed to stars due to confusion
        
        static let fullStarName = "StarsFull"
        static let emptyStarName = "StarsEmpty"
        
        static let bannerName = "BannerFixed"
        
        static let popupButtonNames = ["MenuButton", "PlayButton", "ResetButton", "CancelButton"]
        
        static let scoreScoreKey = "score"
        static let scoreFruitsKey = "fruits"
        // CHANGED TO STARS BECAUSE TWO FRUITS IS CONFUSING - CHANGE IMAGES!
             //////////////////////     //////////////////////     //////////////////////     //////////////////////     //////////////////////     //////////////////////     //////////////////////     //////////////////////     //////////////////////     //////////////////////     //////////////////////     //////////////////////     //////////////////////     //////////////////////
        static let scoreStarsKey = "stars"
       
        static let pausedKey = "Paused"
        static let completedKey = "Completed"
        static let failedKey = "Failed"
        
        static let playerIdleAtlas = "Player Idle Atlas"
        static let playerRunAtlas = "Player Run Atlas"
        static let playerJumpAtlas = "Player Jump Atlas"
        static let playerDieAtlas = "Player Die Atlas"
        
        static let idlePrefixKey = "Idle_"
        static let runPrefixKey = "Run_"
        static let jumpPrefixKey = "Jump_"
        static let diePrefixKey = "Die_"
        
        static let fruitRotateAtlas = "Fruit Rotate Atlas"
        static let fruitPrefixKey = "rosehip"
        
        static let jumpUpActionKey = "JumpUp"
        static let brakeDescendActionKey = "BrakeDescend"
        
        static let fruitDustEmitterKey = "FruitDustEmitter"
        static let brakeSparkEmitterKey = "BrakeSparkEmitterKey"
    }
    
}
