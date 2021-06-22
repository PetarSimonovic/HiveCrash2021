//
//  EnemyHive.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 13/06/2021.
//

import Foundation
import SpriteKit

class EnemyHive : Hive {
 
    var discovered: Bool = false
    
    
    func choosePosition(_ playerColumn: Int, _ playerRow: Int, _ map: SKTileMapNode) {
        self.column = Int.random(in: 0...11)
        self.row = Int.random(in: 0...10)
        if self.column == playerColumn && self.row == playerRow {
            choosePosition(playerColumn, playerRow, map)
        }
        self.location = map.centerOfTile(atColumn: column, row: row)

    
    }
    
   override func expandHive(_ bees: Int, _ infoPane: InfoPane) {
        if bees % 5 == 0 {
            self.maxPollen += 25
        }
    }
}
