//
//  CombatController.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 16/06/2021.
//

import Foundation
import SpriteKit

extension GameScene {
    
    // bees are locked into combat if they collide
    // the victor is the bee with the highest health + attack
    // the victor takes the loser's pollen, up to the victor's max pollen capacity
    // the loser is left with no pollen
    
    func checkCombat(_ bee: Bee) {
      
        for enemyHive in enemyHives {
            checkBeeCombat(bee, enemyHive)
        }
    }
    
    func checkBeeCombat(_ bee: Bee, _ enemyHive: EnemyHive) {
        for enemyBee in enemyHive.bees {
            if enemyBee.inHive == false && bee.inCombat == false && enemyBee.inCombat == false {
            if enemyBee.currentRow == bee.currentRow && enemyBee.currentColumn == bee.currentColumn {
                print("Bee combat meets conditions for fight")
                beesFight(bee, enemyBee, enemyHive)
            }
        }
        
    }
    }
    
    
    func beesFight(_ bee: Bee, _ enemyBee: Bee, _ enemyHive: EnemyHive) {
        infoPane.updateGameStatus("\(bee.name) is in combat with \(enemyBee.name)")
        print("Bees are figthing")
        setCombatUp(bee)
        setCombatUp(enemyBee)
        let fightSequence = createFightSequence()
        let calculateSequence = createCalculateSequence(bee, enemyBee, enemyHive)
        bee.sprite.run(SKAction.repeat(fightSequence, count: 5))
        enemyBee.sprite.run(SKAction.repeat(fightSequence, count: 5))
        bee.sprite.run(calculateSequence)
      
    }
    
    func setCombatUp(_ bee: Bee) {
        bee.sprite.removeAllActions()
        bee.inCombat = true
        bee.homewardBound = false
        bee.pollenCollecting = false
        print("\(bee.name) is in combat: \(bee.inCombat)")
    }
    
    func createFightSequence() -> SKAction {
        let rotate = SKAction.rotate(byAngle: 10, duration: 0.5)
        let moveIn = SKAction.moveBy(x: 20, y: 20, duration: 0.5)
        let moveOut = SKAction.moveBy(x: -20, y: -20, duration: 0.5)
        return SKAction.sequence([rotate, moveIn, moveOut])
    }
    
    func createCalculateSequence(_ bee: Bee, _ enemyBee: Bee, _ enemyHive: EnemyHive) -> SKAction {
        
        let wait = SKAction.wait(forDuration: 5)
        let calculate = SKAction.run( { self.calculateWinner(bee, enemyBee, enemyHive)} )
        return SKAction.sequence([wait, calculate])

    }
    
    
    func calculateWinner(_ bee: Bee, _ enemyBee: Bee, _ enemyHive: EnemyHive) {
        bee.sprite.removeAllActions()
        enemyBee.sprite.removeAllActions()
        if bee.health + bee.attack == enemyBee.health + enemyBee.attack {
            print("Draw")
            bee.health -= 1
            enemyBee.health -= 1
            infoPane.updateGameStatus("Draw: \(bee.name) has \(bee.health) health")
            updateSavedBee(bee.id, "battle", 0)
        } else if bee.health + bee.attack > enemyBee.health + enemyBee.attack {
            print("bee wins")
            enemyBee.health -= 1
            bee.pollen += enemyBee.pollen
            limitPollenToMaxPollen(bee)
            enemyBee.pollen = 0
            infoPane.updateGameStatus("\(bee.name) defeated \(enemyBee.name)")
            updateSavedBee(bee.id, "battle", 1)
        } else {
            print("\(bee.name), \(bee.type) enemy wins")
            infoPane.updateGameStatus("\(enemyBee.name) defeated \(bee.name)")
            bee.health -= 1
            enemyBee.pollen += bee.pollen
            limitPollenToMaxPollen(enemyBee)
            bee.pollen = 0
            updateSavedBee(bee.id, "battle", 0)
        }
        print(bee.health, enemyBee.health)
        print(bee.inCombat, enemyBee.inCombat)
        checkBeeAfterFight(bee, hive)
        checkBeeAfterFight(enemyBee, enemyHive)
    }
    
    func checkBeeAfterFight(_ bee: Bee, _ hive: Hive) {
        print("Checking")
        bee.setDestination(hive.location, hive.column, hive.row)
        bee.health <= 0 ? killBee(bee, hive) : bee.flyHome(hive.location, flightSpeed(bee, hive.location))
    }
    
    
}
