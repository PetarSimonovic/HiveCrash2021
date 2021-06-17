//
//  CombatController.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 16/06/2021.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func checkCombat(_ bee: Bee) {
        
        for enemyBee in enemyHive.bees {
            if enemyBee.inHive == false && bee.inCombat == false && enemyBee.inCombat == false {
//            print("Bee combat rows", bee.currentColumn, bee.currentRow, enemyBee.inCombat)
//            print("Bee enemy rows", enemyBee.currentColumn, enemyBee.currentRow, enemyBee.inCombat)
            if enemyBee.currentRow == bee.currentRow && enemyBee.currentColumn == bee.currentColumn {
                print("Bee combat meets conditions for fight")
                beesFight(bee, enemyBee)
            }
        }
        
    }
    }
    
    func beesFight(_ bee: Bee, _ enemyBee: Bee) {
        infoPane.updateGameStatus("\(bee.name) is in combat with \(enemyBee.name)")
        print("Bees are figthing")
        setCombatUp(bee)
        setCombatUp(enemyBee)
        let rotate = SKAction.rotate(byAngle: 10, duration: 0.5)
        let moveIn = SKAction.moveBy(x: 10, y: 10, duration: 0.5)
        let moveOut = SKAction.moveBy(x: -10, y: -10, duration: 0.5)
        let calculate = SKAction.run( { self.calculateWinner(bee, enemyBee)} )
        let wait = SKAction.wait(forDuration: 5)
        let fightSequence = SKAction.sequence([rotate, moveIn, moveOut])
        let calculateSequence = SKAction.sequence([wait, calculate])
        bee.sprite.run(SKAction.repeat(fightSequence, count: 5))
        enemyBee.sprite.run(SKAction.repeat(fightSequence, count: 5))
        bee.sprite.run(calculateSequence)
      
    }
    
    func setCombatUp(_ bee: Bee) {
        bee.inCombat = true
        bee.sprite.removeAllActions()

        
    }
    
    func calculateWinner(_ bee: Bee, _ enemyBee: Bee) {
        if bee.health == enemyBee.health {
            print("Draw")
            bee.health = 1
            enemyBee.health = 1
            infoPane.updateGameStatus("Draw: \(bee.name) has \(bee.health) health")
            bee.flyHome(hive.location, flightSpeed(bee, hive.location))
            enemyBee.flyHome(enemyHive.location, flightSpeed(enemyBee, hive.location))
        } else if bee.health > enemyBee.health {
            print("bee wins")
            bee.health -= enemyBee.health
            infoPane.updateGameStatus("\(bee.name) defeated \(enemyBee.name)")
            bee.flyHome(hive.location, flightSpeed(bee, hive.location))
            killBee(enemyBee, enemyHive)
            bee.inCombat = false
        } else {
            print("enemy wins")
            enemyBee.health -= bee.health
            infoPane.updateGameStatus("\(enemyBee.name) defeated \(bee.name)")
            enemyBee.flyHome(enemyHive.location, flightSpeed(enemyBee, hive.location))
            killBee(bee, hive)
            enemyBee.inCombat = false
        }
    }
}
