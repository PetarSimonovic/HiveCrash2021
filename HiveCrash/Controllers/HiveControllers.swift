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
        removeFlower(column, row)
        addMeadow(tiles.meadow, hive.column, hive.row)
        moveHive = false
        let oldHive = hive.location
        hive.pollen -= hiveCost
        migrateBees(oldHive, location, column, row)
        }
        if hive.isPlaced == true {
           infoPane.updateGameStatus("Hive has moved")
        } else {
        tiles.fogCount -= 1
        infoPane.updateGameStatus("Hive created")
        startTimer()
                }
      let centredLocation = map.centerOfTile(atColumn: column, row: row)
      hive.place(centredLocation, column, row)
      
      clearFog(hive.column, hive.row, true)
      map.setTileGroup(tiles.hive, forColumn: hive.column, row: hive.row)
      map.addChild(hive.node)
    }
    
  
    
    func feedBees() {
        print("bees are eating")
        for bee in hive.bees {
            hive.pollen -= bee.appetite
            hive.pollen <= 0 ? beeStarves(bee) : beeEats(bee)
            hive.checkNoPollen()
      }

    }
    
    func allowHiveMove() {
        print("In allowHiveMove")
        for bee in hive.bees {
            print("\(bee.name) inHive", bee.inHive)
            print("\(bee.name) scout", bee.scout)
            print(bee.inHive, bee.scout)
            if bee.inHive == false {
                print("InHive False")
                infoPane.updateGameStatus("All bees must be in hive to move")
                return
            } else if bee.scout == true {
                print("Scout is True")
                infoPane.updateGameStatus("Already scouting new location")
                return
            } else {
                print("All good for Hive Move")
                infoPane.updateGameStatus("Select meadow for new hive")
                moveHive = true
            }
        }
    }
    
    func refuseHiveMove() {
        infoPane.updateGameStatus("Not enough pollen to move the hive")
    }
    
    func newHive(_ bee: Bee) {
        infoPane.updateGameStatus("\(bee.name) has found a meadow for new hive")
        bee.settle()
        let newHiveLocaiton = map.centerOfTile(atColumn: bee.destinationColumn, row: bee.destinationRow)
        placeHive(newHiveLocaiton, bee.destinationColumn, bee.destinationRow)
    }
    
    func checkHivePollen() {
        if hive.pollen >= beeCost {
            setButtonAlpha(1.0)
        } else {
            setButtonAlpha(dimButton)
        }
    }
    
}
