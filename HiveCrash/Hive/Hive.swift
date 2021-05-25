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
    var location = CGPoint(x: 0, y: 0)
    

    func place(_ column: Int, _ row: Int, _ x: CGFloat, _ y: CGFloat) {
        print("Hive placed at", column, row)
        isPlaced = true
        self.column = column
        self.row = row
        self.location = CGPoint(x: x, y: y)
    }
    
    
}


