//
//  enemyHiveController.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 14/06/2021.
//

import Foundation
import SpriteKit

extension GameScene {
    
    
    func controlEnemyHive() {
        for enemyBee in enemyHive.bees {
          enemyBee.updatePollenCloud()
                switch enemyBee.inHive {
                case true:
                   return
                default:
                    checkEnemyFlightPath(enemyBee)
                }
               
                }
        }
    
    func releaseEnemyBee(_ enemyBee: Bee) {
        enemyHive.bees.rotateBees()
        let destination = map.centerOfTile(atColumn: hive.column, row: hive.row)
        enemyBee.setDestination(destination, hive.column, hive.row)
        map.addChild(enemyBee.sprite)
        enemyBee.sprite.position = enemyHive.location
        enemyBee.fly(enemyHive.location, flightSpeed(enemyBee, enemyBee.destination))
    }
    
    func checkEnemyFlightPath(_ enemyBee: Bee) {
        let column = self.map.tileColumnIndex(fromPosition: enemyBee.sprite.position)
        let row = self.map.tileRowIndex(fromPosition: enemyBee.sprite.position)
        let tile = self.map.tileDefinition(atColumn: column, row: row)
       // print("Bee tile", column, row)
      //  checkRange(enemyBee, column, row)
        switch tile?.name! {
        case "fog":
             clearFog(column, row, false)
        case "lake":
            if  enemyBee.pollen != 0 {
             let pollenLoss =  enemyBee.pollen - (enemyBee.speed/10) / 2
                enemyBee.pollen -= pollenLoss
            }
        case "rock":
            enemyBee.flyHome(enemyHive.location, flightSpeed(enemyBee, enemyHive.location))
        case "meadow":
            if enemyBee.pollen != 0 {
              shedPollen(enemyBee, column, row)
            }
        case "flowerMeadow":
            checkPollination(enemyBee, column, row)
        case "hive":
            enemyBee.flyHome(enemyHive.location, flightSpeed(enemyBee, enemyHive.location))
            hive.pulse()
       //     infoPane.updateGameStatus("\(enemyBee.name) stole \(enemyBee.pollenCapacity) pollen from hive")

        case "enemyHive":
            if enemyBee.homewardBound == true {
            enemyHive.pulse()
            enemyHive.updatePollen(enemyBee)
            enemyBee.homewardBound = false
            } else {
                enemyHive.pulse()
            }
        default:
            return
        }
    }
    
    func activateEnemies() {
        let launch = SKAction.run( {self.launchEnemy()} )
        let pauseLaunch = SKAction.wait(forDuration: 10)
        let launchSequence = SKAction.sequence([launch, pauseLaunch])
        self.run(SKAction.repeatForever(launchSequence))
    }
    
    
    func launchEnemy() {
        if let enemyBee = enemyHive.bees.first(where: { $0.inHive == true} ) {
                releaseEnemyBee(enemyBee)
            }
        }
}
