//
//  ScoreManager.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 16/05/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import Foundation

struct ScoreManager {
    
    static func getCurrentScore(for levelKey: String) -> [String:Int] {
        if let existingData = UserDefaults.standard.dictionary(forKey: levelKey) as? [String:Int] {
            return existingData
        } else {
            return [GameConstants.StringConstants.scoreScoreKey:0, GameConstants.StringConstants.scoreStarsKey:0, GameConstants.StringConstants.scoreFruitsKey:0]
        }
    }
    
    static func updateScore(for levelKey: String, and score: [String:Int]) {
        UserDefaults.standard.set(score, forKey: levelKey)
        UserDefaults.standard.synchronize()
    }
    
    static func compare(scores: [[String:Int]], in levelKey: String) {
        var newHighscore = false
        let currentScore = getCurrentScore(for: levelKey)
        
        var maxScore = currentScore[GameConstants.StringConstants.scoreScoreKey]!
        var maxStars = currentScore[GameConstants.StringConstants.scoreStarsKey]!
        var maxFruits = currentScore[GameConstants.StringConstants.scoreFruitsKey]!
        
        for score in scores {
            if score[GameConstants.StringConstants.scoreScoreKey]! > maxScore {
                maxScore = score[GameConstants.StringConstants.scoreScoreKey]!
                newHighscore = true
            }
            if score[GameConstants.StringConstants.scoreStarsKey]! > maxStars {
                maxStars = score[GameConstants.StringConstants.scoreStarsKey]!
                newHighscore = true
            }
            if score[GameConstants.StringConstants.scoreFruitsKey]! > maxFruits {
                maxFruits = score[GameConstants.StringConstants.scoreFruitsKey]!
                newHighscore = true
            }
        }
        
        if newHighscore {
            let newScore = [GameConstants.StringConstants.scoreScoreKey: maxScore, GameConstants.StringConstants.scoreStarsKey: maxStars, GameConstants.StringConstants.scoreFruitsKey: maxFruits]
            
            updateScore(for: levelKey, and: newScore)
        }
        
        
    }
    
}
