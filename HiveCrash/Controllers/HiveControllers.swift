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
        if hive.isPlaced == true {
           infoPane.updateGameStatus("Hive has moved")
        } else {
        infoPane.updateGameStatus("Hive created")
        5.times {
           addBee()
        }
        gameTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(updateHive), userInfo: nil, repeats: true)
        }
      self.hive.place(location, column, row)
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
            hive.pollen -= bee.appetite
            hive.pollen <= 0 ? beeStarves(bee) : beeEats(bee)
      }
    }
}
