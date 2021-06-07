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
        map.addChild(bee.sprite)
        bee.sprite.position = hive.location
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
            if bee.homewardBound == true {
            hive.pulse()
            hive.updatePollen(bee)
            infoPane.updateBeeStatus("\(bee.name) has returned to the hive")
            } else {
                hive.pulse()
            }
        default:
            return
        }
    }
    
    func beeEats(_ bee: Bee) {
        bee.health += 1
        infoPane.updateBeeStatus("\(bee.name) has eaten. Health is now \(bee.health)")
       }
    
     
    
    func beeStarves(_ bee: Bee) {
        bee.health -= 1
        if bee.health <= 0 {
           killBee(bee)
        } else {
        infoPane.updateBeeStatus("Not enough food for \(bee.name). Health is now \(bee.health)")
       }
    }
    
    func killBee(_ bee: Bee) {
        if let beeIndex = bees.firstIndex(where: {$0.id == bee.id}) {
        bees.remove(at: beeIndex)
        infoPane.updateBeeStatus("\(bee.name) starved")
        }
     }
    
    
}
