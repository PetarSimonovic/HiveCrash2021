//
//  HiveControllers.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 25/05/2021.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func placeHive(_ location: CGPoint, _ column: Int, _ row: Int) {
    self.hive.place(location, column, row)
    clearFog(hive.column, hive.row)
    map.setTileGroup(tiles.hive, forColumn: hive.column, row: hive.row)
    }
}
