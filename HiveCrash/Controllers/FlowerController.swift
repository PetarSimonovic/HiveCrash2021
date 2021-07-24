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
    
    func timeFlowers() {
        for flower in flowers {
            flower.bloomTimer()
        }
    }

    func checkPollination(_ bee: Bee, _ column: Int, _ row: Int, _ hive: Hive) {
        for flower in flowers {
            if flower.column == column && flower.row == row && flower.hasBee == false {
                if flower.inBloom && bee.scout == false {
                    flower.hasBee = true
                    bee.setDestination(hive.location, column, row)
                    bee.flowerTime = flower.bloomTime
                    bee.collectPollen(flower, hive.location, flightSpeed(bee, hive.location))
                    bee.flowerTime = flower.bloomTime
                    bee.pollenCollecting = true
                } else if bee.pollenCollecting {
                    bee.pollenCollecting = false
                    calculatePollen(bee, flower)

                    bee.homewardBound = false
                    bee.flyHome(hive.location, flightSpeed(bee, hive.location))
                    continue
                }
            }
        }
    }
    
    func calculatePollen(_ bee: Bee, _ flower: Flower) {
        infoPane.updateGameStatus("\(bee.name) now has \(bee.pollen) pollen")
        let pollenCounter = flower.bloomTime - bee.flowerTime
        let pollenCollected = (pollenCounter/flower.bloomTime) * 100
        bee.pollen = (flower.pollen/100) * Int(pollenCollected)
        flower.bloomTime = 0
        bee.flowerTime = 0
        bee.checkPollenCapacity()
        infoPane.updateGameStatus("\(bee.name) collected \(pollenCollected)% of pollen from flower")
        infoPane.updateGameStatus("\(bee.name) has \(bee.pollen) pollen")
        updateSavedBee(bee.id, "flower", 1)
        updateSavedBee(bee.id, "pollen", bee.pollen)
        }
    
    func shedPollen(_ bee: Bee, _ column: Int, _ row: Int) {
      if let meadow = meadows.first(where: {$0.column == column && $0.row == row}) {
        let initialPollen = bee.pollen
        if bee.pollen - (bee.speed/10) / 2 > 0 {
             meadow.pollen += (bee.speed/10) / 2
            bee.pollen -= (bee.speed/10) / 2
        } else {
            meadow.pollen += bee.pollen
            bee.pollen -= bee.pollen
        }
        infoPane.updateGameStatus("\(bee.name) shed \(initialPollen - bee.pollen) over \(column)-\(row)")
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
    
    func removeFlower(_ column: Int, _ row: Int) {
        if let flowerIndex = flowers.firstIndex(where: {$0.column == column && $0.row == row}) {
           let flower = flowers[flowerIndex]
            flower.sprite.removeFromParent()
            flowers.remove(at: flowerIndex)

        }
    }
}

   
