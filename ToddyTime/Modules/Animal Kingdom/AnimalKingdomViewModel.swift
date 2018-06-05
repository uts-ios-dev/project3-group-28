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
    
    // correct animal for current round
    var correctAnimal: String {
        return correctAnimals[currentRound - 1]
    }
    
    
    init(frame: CGRect) {
        self.frame = frame
        correctAnimals = try! appDatabase.getAnimal(numberOfAnimals: AppDefault.numberOfRound)
    }
    
    init() {
    }
    
    
    //generate possible rect origins
    private func getRandomPointArray() -> [CGPoint] {
        var randomPointArray = [CGPoint]()
        let numberOfButtonInaRow = Int(frame.width / AppDefault.buttonLength)
        let numberOfButtonInaColumn = Int(frame.height / AppDefault.buttonLength)
        
        for rowNumber in 0 ..< numberOfButtonInaColumn {
            let y = rowNumber * Int(AppDefault.buttonLength)
            for columnNumber in 0 ..< numberOfButtonInaRow {
                let x = columnNumber * Int(AppDefault.buttonLength)
                randomPointArray.append(CGPoint(x: x, y: y))
            }
        }
        return randomPointArray
    }
    
    
    //setup button for new frame
    func setupNewFrame(frame: CGRect) {
        self.frame = frame
        randomPoints = [CGPoint]()
        generateRandomPoint()
    }
    
    
    
    //setups next round
    func setupNextRound() -> Bool {
        currentRound += 1
        guard currentRound <= AppDefault.numberOfRound else { return false }
        randomPoints = [CGPoint]()
        randomAnimals = [String]()
        generateRandomPoint()
        generateRandomAnimals()
        return true
    }
    
    
    //generate random positions for buttons
    fileprivate func generateRandomPoint() {
        var randomPointArray = getRandomPointArray()
        
        //select random points from randomPointArray
        for _ in 0 ..< AppDefault.totalNumberOfAnimalsDisplayed {
            let randomIndex = Int.randomNumberBetween(lowerNumber: 0, upperNumber: randomPointArray.count - 1)
            randomPoints.append(randomPointArray.remove(at: randomIndex))
        }
        
    }
    
    //generate random animals from database
    private func generateRandomAnimals() {
        randomAnimals = [correctAnimal]
        try! randomAnimals.append(contentsOf: appDatabase.getAnimal(numberOfAnimals: AppDefault.totalNumberOfAnimalsDisplayed - 1, except: correctAnimal))
    }
    
}
