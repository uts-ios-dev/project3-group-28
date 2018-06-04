//
//  AnimalKingdomViewModel.swift
//  ToddyTime
//
//  Created by Shankhar on 5/26/18.
//  Copyright © 2018 Shankhar. All rights reserved.
//

import UIKit

class AnimalKingdomViewModel {
    
    private var frame = CGRect()
    private(set) var randomPoints = [CGPoint]()
    private(set) var randomAnimals = [String]()
    
    private(set) var correctAnimals = [String]()
    private var currentRound = 0
    
    var correctAnimal: String {
        return correctAnimals[currentRound - 1]
    }
    
    init(frame: CGRect) {
        self.frame = frame
        correctAnimals = try! appDatabase.getAnimal(numberOfAnimals: AppDefault.numberOfRound)
    }
    
    init() {
    }
    
    
    //setup button for new frame
    func setupNewFrame(frame: CGRect) {
        
    }
    
    
    //setups next round
    func setupNextRound() -> Bool {
        currentRound += 1
        guard currentRound <= AppDefault.numberOfRound else { return false }
        randomPoints = [CGPoint]()
        randomAnimals = [String]()
        generateButton()
        return true
    }
    
    
    //generate buttons in animals in random positions
    private func generateButton() {
        let frame = CGRect(origin: self.frame.origin, size: CGSize(width: self.frame.size.width - AppDefault.buttonLength, height: self.frame.size.height - AppDefault.buttonLength))
        for _ in 0 ..< AppDefault.totalNumberOfAnimalsDisplayed {
            randomPoints.append(getRandomPoint(in: frame))
        }
        randomAnimals = [correctAnimal]
        try! randomAnimals.append(contentsOf: appDatabase.getAnimal(numberOfAnimals: AppDefault.totalNumberOfAnimalsDisplayed - 1, except: correctAnimal))
    }
    
    
    //generate random point for butto so that no button intersect with each other
    private func getRandomPoint(in frame: CGRect) -> CGPoint {
        while true {
            let randomPoint = CGPoint.getRandomPoint(in: frame)
            var isValidPoint = true
            for eachPoint in randomPoints {
                if AppDefault.does(buttonAtOrigin: eachPoint, intersectWithButtonAtOrigin: randomPoint) {
                    isValidPoint = false
                    break
                }
            }
            if isValidPoint {
                return randomPoint
            }
        }
    }
}
