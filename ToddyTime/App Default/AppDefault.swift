//
//  AppDefault.swift
//  ToddyTime
//
//  Created by Shankhar on 5/26/18.
//  Copyright © 2018 Shankhar. All rights reserved.
//

import UIKit

typealias CompletionClosure = (() -> ())?

/// All default values of app

struct AppDefault {
    static let buttonLength:CGFloat = 70.0 // height and weight of picture button
    static let buttonSize = CGSize(width: buttonLength, height: buttonLength)
    
    //game constants
    static let numberOfRound = 10       // number of rounds animal kingdom goes for
    static let totalNumberOfAnimalsDisplayed = 4        // number of animal displayed in each round
    static let totalNumberOfObjectDisplayed = 6         // number of object displayed in picture play mode
    static let totalNumberObjectListed = 4              // number of object listed in picture play mode
    
    
    // App Default colors
    static let greenColor = #colorLiteral(red: 0.5176470588, green: 0.6745098039, blue: 0.3450980392, alpha: 1)
    static let yellowColor = #colorLiteral(red: 0.937254902, green: 0.8666666667, blue: 0.3725490196, alpha: 1)
    static let blueColor = #colorLiteral(red: 0.3333333333, green: 0.5921568627, blue: 0.6980392157, alpha: 1)
    static let whiteColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    static let blackColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
}
