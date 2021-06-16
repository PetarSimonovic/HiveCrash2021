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
            print("Bee in combat?", bee.inCombat)
            if enemyBee.currentRow == bee.currentRow && enemyBee.currentColumn == bee.currentColumn {
                beesFight(bee, enemyBee)
            }
        }
        
    }
    
    func beesFight(_ bee: Bee, _ enemyBee: Bee) {
        print("Bees are figthing")
        bee.inCombat = true
        enemyBee.inCombat = true
        bee.sprite.removeAllActions()
        enemyBee.sprite.removeAllActions()
    }
}
