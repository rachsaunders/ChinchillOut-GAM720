//
//  ARHelper.swift
//  ChinchillOut-GAM720
//
//  Created by Rachel Saunders on 21/06/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import Foundation

enum GameStateL4W1:Int {
    case none, spawnEvilBirds
}

func randomPosition (lowerBound lower:Float, upperBound upper:Float) -> Float {
    return Float(arc4random()) / Float(UInt32.max) * (lower - upper) + upper
}

func randomNumber (lowerBound lower:Int, upperBound upper:Int) -> Int {
    return Int(arc4random()) / Int(UInt32.max) * (lower - upper) + upper
}

