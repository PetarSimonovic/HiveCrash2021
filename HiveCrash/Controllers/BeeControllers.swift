//
//  BeeControllers.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 25/05/2021.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func addBee(_ location: CGPoint, _ column: Int, _ row: Int) {
        let bee = Bee(location, column, row)
     //   let beeSprite = bee.createBee()
        map.addChild(bee.sprite)
        bees.append(bee)
        bee.sprite.position = hive.location
        let flight = SKAction.move(to: bee.destination, duration: bee.speed)
        let flightPath = SKAction.sequence([flight, flyHome()])
        bee.sprite.run(flightPath)
    }
    
    func beeFlight() {
    
        for bee in bees {
            print(bee)
            if  bee.homewardBound == false {
                checkFlightPath(bee)
     }
    }
}
    
    func checkFlightPath(_ bee: Bee) {
        let column = self.map.tileColumnIndex(fromPosition: bee.sprite.position)
        let row = self.map.tileRowIndex(fromPosition: bee.sprite.position)
        let tile = self.map.tileDefinition(atColumn: column, row: row)
        if let _ = tile?.userData?.value(forKey: "fog") {
            self.clearFog(column, row, false)
        }
        if let _ = tile?.userData?.value(forKey: "rock") {
            bee.sprite.removeAllActions()
            bee.sprite.run(self.flyHome())
            bee.homewardBound = true
        }
    }

    func flyHome() -> SKAction {
       return SKAction.move(to: hive.location, duration: 8)
    }
    

}
