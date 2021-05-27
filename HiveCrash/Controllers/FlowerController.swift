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
    
}
