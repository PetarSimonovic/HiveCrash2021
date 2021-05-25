//
//  Hive.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 25/05/2021.
//

import Foundation

class Hive {
    
    var isPlaced: Bool = false
    var location: [Int] = []

    func place(_ column: Int, _ row: Int ) {
        print("Hive placed at", column, row)
        isPlaced = true
        location = [column, row]
    }
    
    
}


