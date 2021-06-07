//
//  FlowerController.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 26/05/2021.
//

import Foundation
import SpriteKit

extension GameScene {
    
func addFlower(_ tile: SKTileGroup, _ column: Int, _ row: Int) {
    if tile.name! == "flowerMeadow" {
    
        let location = map.centerOfTile(atColumn: column, row: row)
        let flower = Flower(location, column, row)
 //   let beeSprite = bee.createBee()
        map.addChild(flower.sprite)
        flowers.append(flower)
        flower.sprite.position = location
    }

}

    func checkPollination(_ bee: Bee, _ column: Int, _ row: Int) {
        for flower in flowers {
            if flower.column == column && flower.row == row {
                if flower.inBloom {
                    bee.collectPollen(flower, hive.location, flightSpeed(bee, hive.location))
                    calculatePollen(bee, flower)
                } else if bee.pollenCollecting {
                    bee.pollenCollecting = false
                    if  bee.homewardBound {
                        bee.homewardBound = false
                        bee.flyHome(hive.location, flightSpeed(bee, hive.location))
                        continue
                    } else {
                        bee.fly(hive.location, flightSpeed(bee, hive.location))
                        continue
                    }
                }
            }
        }
    }
    
    func calculatePollen(_ bee: Bee, _ flower: Flower) {
        if bee.pollenCollecting == false {
            if flower.pollen > bee.speed/10 {
                bee.pollen += bee.speed/10
                flower.pollen -= bee.speed/10
            } else {
                bee.pollen += flower.pollen
                flower.pollen = 0
            }
        }
        bee.pollenCollecting = true
    }
    
    func shedPollen(_ bee: Bee, _ column: Int, _ row: Int) {
      if let meadow = meadows.first(where: {$0.column == column && $0.row == row}) {
      if bee.pollen - (bee.speed/10) / 2 > 0 {
             meadow.pollen += (bee.speed/10) / 2
            bee.pollen -= (bee.speed/10) / 2
        } else {
            meadow.pollen += bee.pollen
            bee.pollen -= bee.pollen
        }
        print("Meadow", meadow.pollen)
        if meadow.pollen >= 100 && meadow.flowerMeadow == false {
            infoPane.updateGameStatus("Meadow \(column)-\(row) pollinated: flowers will bloom")
            meadow.flowerMeadow = true
            createFlowerMeadow(column, row)
        }
        }
        
        }
     
    func createFlowerMeadow(_ column: Int, _ row: Int) {
        map.setTileGroup(tiles.flowerMeadow, forColumn: column, row: row)
        addFlower(tiles.flowerMeadow, column, row)
    }
}

   
