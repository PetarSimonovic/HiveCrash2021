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
        print("Hive", hive.location)
        print("Bee position", bee.sprite.position)
        print("Bee destination", bee.destination)
        let beeSpeed = flightSpeed(bee.sprite.position, bee.destination, bee.speed)
        let flight = SKAction.move(to: bee.destination, duration: beeSpeed)
        let removeBee = SKAction.run(bee.sprite.removeFromParent)
        let flightPath = SKAction.sequence([flight, flyHome(bee, bee.destination), removeBee])
        bee.sprite.run(flightPath)
    }
    
    func beeFlight() {
    
        for bee in bees {
            if  bee.homewardBound == false {
                checkFlightPath(bee)
     }
    }
}
    
    func checkFlightPath(_ bee: Bee) {
        let column = self.map.tileColumnIndex(fromPosition: bee.sprite.position)
        let row = self.map.tileRowIndex(fromPosition: bee.sprite.position)
        let tile = self.map.tileDefinition(atColumn: column, row: row)
        
        switch tile?.name! {
        case "fog":
             self.clearFog(column, row, false)
        case "rock":
            bee.sprite.removeAllActions()
            let removeBee = SKAction.run(bee.sprite.removeFromParent)
            let returnToHive = SKAction.sequence([flyHome(bee, bee.sprite.position), removeBee])
            bee.sprite.run(returnToHive)
            bee.homewardBound = true
        default:
            return
        }
    }

    func flyHome(_ bee: Bee, _ beeLocation: CGPoint) -> SKAction {
        print ("flying home")
        let beeSpeed = flightSpeed(beeLocation, hive.location, bee.speed)
        return SKAction.move(to: hive.location, duration: beeSpeed)
    }
    

}
