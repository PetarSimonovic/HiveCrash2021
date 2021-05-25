//
//  Hive.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 25/05/2021.
//

import Foundation
import SpriteKit

class Hive {
    
    var isPlaced: Bool = false
    var column: Int = 0
    var row: Int = 0
    var location = CGPoint()
    

    func place(_ location: CGPoint, _ column: Int, _ row: Int) {
        print("Hive placed at", column, row)
        isPlaced = true
        self.column = column
        self.row = row
        self.location = location
    }
    
    
}


