//
//  BeeControllers.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 25/05/2021.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func addBee(_ destination: CGPoint, _ column: Int, _ row: Int) {
        let bee = Bee(destination, column, row)
     //   let beeSprite = bee.createBee()
        map.addChild(bee.sprite)
        bees.append(bee)
        bee.sprite.position = hive.location
        hive.pulse()
        bee.fly(hive.location, flightSpeed(bee, bee.destination))
    }
    
    func beeFlight() {
        for bee in bees {
            checkFlightPath(bee)
            }
    }
    
    func checkFlightPath(_ bee: Bee) {
        let column = self.map.tileColumnIndex(fromPosition: bee.sprite.position)
        let row = self.map.tileRowIndex(fromPosition: bee.sprite.position)
        let tile = self.map.tileDefinition(atColumn: column, row: row)
        switch tile?.name! {
        case "fog":
             clearFog(column, row, false)
        case "rock":
            bee.flyHome(hive.location, flightSpeed(bee, hive.location))
        case "flowerMeadow":
            checkPollination(bee, column, row)
        case "hive":
            hive.pulse()
        default:
            return
        }
    }
    
    
}
