//
//  Database.swift
//  ToddyTime
//
//  Created by Shankhar on 5/26/18.
//  Copyright © 2018 Shankhar. All rights reserved.
//

import Foundation

let appDatabase = Database.instance

struct Database {
    
    private(set) var animals = [String]()
    private(set) var objects = [String]()
    
    static let instance = Database()
    
    
    //get data form database.plist file
    init() {
        if let path = Bundle.main.path(forResource: "Database", ofType: "plist"), let database = NSDictionary(contentsOfFile: path) {
            animals = (database.value(forKey: "animal") as? [String]) ?? [String]()
            objects = (database.value(forKey: "thing") as? [String]) ?? [String]()
        }
    }
    
    
    //get any random animal
    func getRandomAnimal() -> String {
         return animals[Int.randomNumberBetween(lowerNumber: 0, upperNumber: animals.count - 1)]
    }
    
    
    //get any random object
    func getRandomObject() -> String {
        return objects[Int.randomNumberBetween(lowerNumber: 0, upperNumber: objects.count - 1)]
    }
    
    
    
    /// get number of random objects
    ///
    /// - Parameters:
    ///   - numberOfObject: number of object required
    ///   - object: result must not include this object
    /// - Returns: random objects form the database
    /// - Throws: exception if data count is not sufficient
    
    func getObject(numberOfObject: Int, except object: String = "") throws -> [String] {
        var tempObject = objects.filter{ return $0 != object }
        guard numberOfObject <= tempObject.count else {throw AppError.DataCountError}
        return Array( 0 ..< numberOfObject).map{_ in tempObject.remove(at: Int.randomNumberBetween(lowerNumber: 0, upperNumber: tempObject.count - 1))}
    }
    
    
    
    // get number of random animals form database
    func getAnimal(numberOfAnimals: Int, except animal: String = "") throws -> [String] {
        var tempAnimal = animals.filter{ return $0 != animal }
        guard numberOfAnimals <= tempAnimal.count else {throw AppError.DataCountError}
        return Array( 0 ..< numberOfAnimals).map{_ in tempAnimal.remove(at: Int.randomNumberBetween(lowerNumber: 0, upperNumber: tempAnimal.count - 1))}
    }
}

