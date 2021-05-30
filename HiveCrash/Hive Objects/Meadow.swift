//
//  Meadow.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 30/05/2021.
//

import Foundation

class Meadow {
    var pollen: Int
    var flowerMeadow: Bool
    var column: Int
    var row: Int
    
    
    init(_ column: Int, _ row: Int) {
        self.column = column
        self.row = row
        self.flowerMeadow = false
        self.pollen = 0
    }
    
    
}
