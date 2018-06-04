//
//  CGPoint+Extension.swift
//  ToddyTime
//
//  Created by Shankhar on 5/22/18.
//  Copyright © 2018 Shankhar. All rights reserved.
//

import UIKit

import UIKit

extension CGPoint {
    
    func distanceFrom(point: CGPoint) -> CGFloat {
        let xDist = self.x - point.x
        let yDist = self.y - point.y
        return sqrt((xDist * xDist + yDist * yDist))
    }
    
    static func getRandomPoint(in frame: CGRect) -> CGPoint {
        let randomX = CGFloat.randomNumberBetween(lowerNumber: 0, upperNumber: frame.width)
        let randomY = CGFloat.randomNumberBetween(lowerNumber: 0, upperNumber: frame.height)
        return CGPoint(x: randomX, y: randomY)
    }
}

extension CGFloat {
    static func randomNumberBetween(lowerNumber: CGFloat, upperNumber: CGFloat) -> CGFloat {
        let cgUpperNumber = UInt32(upperNumber)
        let cgLowerNumber = UInt32(lowerNumber)
        return CGFloat(UInt32.randomNumberBetween(lowerNumber: cgLowerNumber, upperNumber: cgUpperNumber))
    }
}

extension UInt32 {
    static func randomNumberBetween(lowerNumber: UInt32, upperNumber: UInt32) -> UInt32 {
        if upperNumber > lowerNumber {
            let difference = upperNumber - lowerNumber
            return arc4random_uniform(difference) + lowerNumber
        }
        return 0
    }
}

extension Int {
    static func randomNumberBetween(lowerNumber: Int, upperNumber: Int) -> Int {
        return Int(UInt32.randomNumberBetween(lowerNumber: UInt32(lowerNumber), upperNumber: UInt32(upperNumber)))
    }
}



