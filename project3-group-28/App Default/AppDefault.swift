//
//  AppDefault.swift
//  ToddyTime
//
//  Created by Bipin on 5/26/18.
//  Copyright © 2018 Shankhar. All rights reserved.
//

import UIKit

typealias CompletionClosure = (() -> ())?

struct AppDefault {
    static let buttonLength:CGFloat = 60.0
    static let buttonSize = CGSize(width: buttonLength, height: buttonLength)
    
    //game constants
    static let numberOfRound = 10
    static let totalNumberOfAnimalsDisplayed = 4
    
    
    
    static let greenColor = #colorLiteral(red: 0.5176470588, green: 0.6745098039, blue: 0.3450980392, alpha: 1)
    static let yellowColor = #colorLiteral(red: 0.937254902, green: 0.8666666667, blue: 0.3725490196, alpha: 1)
    static let blueColor = #colorLiteral(red: 0.3333333333, green: 0.5921568627, blue: 0.6980392157, alpha: 1)
    static let whiteColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    static let blackColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    static func does(buttonAtOrigin origin1: CGPoint, intersectWithButtonAtOrigin origin2: CGPoint) -> Bool {
        
        let x1 = Int32(origin1.x)
        let y1 = Int32(origin1.y)
        let x2 = Int32(origin2.x)
        let y2 = Int32(origin2.y)
        let buttonLength = Int32(AppDefault.buttonLength)
        if abs(x1 - x2) >= buttonLength && abs(y1 - y2) >= buttonLength {
            print("found")
            return false
        }
        print(".")
        return true
    }
}
