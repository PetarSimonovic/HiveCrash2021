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
            print("Bee combat rows", bee.currentColumn, bee.currentRow, enemyBee.inCombat)
            print("Bee enemy rows", bee.currentColumn, bee.currentRow, enemyBee.inCombat)
            if enemyBee.currentRow == bee.currentRow && enemyBee.currentColumn == bee.currentColumn && enemyBee.inHive == false {
                print("Bee combat meets conditions for fight")
                beesFight(bee, enemyBee)
            }
        }
        
    }
    
    func beesFight(_ bee: Bee, _ enemyBee: Bee) {
        infoPane.updateGameStatus("\(bee.name) is in combat with \(enemyBee.name)")
        print("Bees are figthing")
        bee.inCombat = true
        enemyBee.inCombat = true
        bee.sprite.removeAllActions()
        enemyBee.sprite.removeAllActions()
    }
}
