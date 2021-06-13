//
//  EnemyHive.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 13/06/2021.
//

import Foundation

class EnemyHive : Hive {
//            
//    override init() {
//        super.init()
//        self.column = 0
//        self.row = 0
//    }
    
     func choosePosition(_ playerColumn: Int, _ playerRow: Int) {
        self.column = Int.random(in: 0...11)
        self.row = Int.random(in: 0...10)
        if self.column == playerColumn && self.row == playerRow {
            choosePosition(playerColumn, playerRow)
        }

    }
}
