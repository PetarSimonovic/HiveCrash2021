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
      if moveHive == true {
        map.setTileGroup(tiles.meadow, forColumn: hive.column, row: hive.row)
        }
      self.hive.place(location, column, row)
      infoPane.updateGameStatus("Hive has moved")
      clearFog(hive.column, hive.row, true)
      map.setTileGroup(tiles.hive, forColumn: hive.column, row: hive.row)
      map.addChild(hive.node)
    }
    
     @objc func updateHive() {
        feedBees()
    }
    
    func feedBees() {
        print("bees are eating")
        for bee in bees {
           hive.pollen -= 5
            hive.pollen <= 0 ? infoPane.updateBeeStatus("Not enough food for \(bee.name)") : infoPane.updateBeeStatus("\(bee.name) has eaten")
      }
    }
}
