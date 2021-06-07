//
//  BeeControllers.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 25/05/2021.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func addBee() {
        let bee = Bee()
     //   let beeSprite = bee.createBee()
       // map.addChild(bee.sprite)
        bees.append(bee)
       // bee.sprite.position = hive.location
       // hive.pulse()
       // bee.fly(hive.location, flightSpeed(bee, bee.destination))
    }
    
    func releaseBee(_ bee: Bee, _ destination: CGPoint, _ column: Int, _ row: Int) {
        bees.rotateBees()
        bee.destination = destination
        bee.destinationColumn = column
        bee.destinationRow = row
        //   let beeSprite = bee.createBee()
        map.addChild(bee.sprite)
        bee.sprite.position = hive.location
        hive.pulse()
        bee.fly(hive.location, flightSpeed(bee, bee.destination))
        infoPane.updateBeeStatus("\(bee.name) has left the hive")
    }

    
    func beeFlight() {
        for bee in bees {
            switch bee.inHive {
            case false:
                bee.pollenCloud.particleBirthRate = CGFloat(bee.pollen)
                checkFlightPath(bee)
            default:
                continue
            }
           
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
        case "meadow":
            if bee.pollen != 0 {
              shedPollen(bee, column, row)
            }
        case "flowerMeadow":
            checkPollination(bee, column, row)
        case "hive":
            hive.pulse()
            hive.updatePollen(bee)
        default:
            return
        }
    }
    
    
}
