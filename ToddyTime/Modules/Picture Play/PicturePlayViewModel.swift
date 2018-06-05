//
//  PicturePlayViewModel.swift
//  ToddyTime
//
//  Created by Shankhar on 5/27/18.
//  Copyright © 2018 Shankhar. All rights reserved.
//


import UIKit

class PicturePlayViewModel {
    
    private var frame = CGRect()
    private(set) var randomPoints = [CGPoint]()
    private(set) var randomObjects = [String]()
    private(set) var answerObjects = [String]()
    private(set) var isRandomObjectSelected = [Bool]()
    
    //checks if all data is selected or not
    var isAllChecked : Bool {
        return !isRandomObjectSelected.contains(false)
    }
    
    
    init(frame: CGRect) {
        self.frame = frame
        print(frame)
        generateButton()
    }
    
    init() {
    }
    
    
    //regenerate button origin after the orientation was updated
    func updateFrame(with frame: CGRect) {
        self.frame = frame
        generateRandomPoints()
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
    
    
    //generate random points
    private func generateRandomPoints() {
        randomPoints = [CGPoint]()
        var randomPointArray = getRandomPointArray()
        for _ in 0 ..< AppDefault.totalNumberOfObjectDisplayed {
            let randomIndex = Int.randomNumberBetween(lowerNumber: 0, upperNumber: randomPointArray.count - 1)
            randomPoints.append(randomPointArray.remove(at: randomIndex))
        }
    }
    
    
    //generate random points and objects
    func generateButton() {
        generateRandomPoints()
        try! randomObjects = appDatabase.getObject(numberOfObject: AppDefault.totalNumberOfObjectDisplayed)
        answerObjects = Array(0 ..< AppDefault.totalNumberObjectListed).map{randomObjects[$0]}
        isRandomObjectSelected = Array(0 ..< AppDefault.totalNumberObjectListed).map{_ in return false}
    }
    
    
    //update selected data array after any object is selected
    func selectObject(object: String) {
        for (index,eachObject) in answerObjects.enumerated() {
            if eachObject == object {
                isRandomObjectSelected[index] = true
                return
            }
        }
    }
    
}
