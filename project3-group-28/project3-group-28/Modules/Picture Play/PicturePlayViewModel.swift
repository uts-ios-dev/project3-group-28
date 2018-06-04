//
//  PicturePlayViewModel.swift
//  ToddyTime
//
//  Created by Shankhar on 5/27/18.
//  Copyright © 2018 Shankhar. All rights reserved.
//


import UIKit

class PicturePlayViewModel {
    
    let totalNumberOfAnimalDisplayed = 4
    private var frame = CGRect()
    private(set) var randomPoints = [CGPoint]()
    private(set) var randomObjects = [String]()
    private(set) var isRandomObjectSelected = [Bool]()
    
    init(frame: CGRect) {
        self.frame = frame
        generateButton()
    }
    
    init() {
    }
    
    func generateButton() {
        let frame = CGRect(origin: self.frame.origin, size: CGSize(width: self.frame.size.width - AppDefault.buttonLength, height: self.frame.size.height - AppDefault.buttonLength))
        for _ in 0 ..< totalNumberOfAnimalDisplayed {
            randomPoints.append(getRandomPoint(in: frame))
            isRandomObjectSelected.append(false)
        }
        try! randomObjects = appDatabase.getObject(numberOfObject: totalNumberOfAnimalDisplayed)
    }
    
    func selectObject(object: String) {
        for (index,eachObject) in randomObjects.enumerated() {
            if eachObject == object {
                isRandomObjectSelected[index] = true
                return
            }
        }
    }
    
    
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
