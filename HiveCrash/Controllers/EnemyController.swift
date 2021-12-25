//
//  enemyHiveController.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 14/06/2021.
//

import Foundation
import SpriteKit

extension GameScene {
    
    
    //ARE ENEMIES EATING, REPRODUCING AND STARVING????
    
    func controlEnemyHives() {
        for enemyHive in enemyHives {
            controlEnemyHive(enemyHive)
        }
    }
    
    func createEnemies(_ numberOfEnemies: Int) {
        print("Creating enemies: ", numberOfEnemies)
        numberOfEnemies.times {
            let enemyHive = EnemyHive()
            populateEnemyHive(4 + level, enemyHive)
            print("EnemyHive created")
            print(enemyHive)
            while checkEnemyHiveTileClash(enemyHive) {
                enemyHive.choosePosition(self.hive.column, self.hive.row, self.map)
            }
            print("EnemyHive locations")
            print("EnemyHive column: \(enemyHive.column), EnemyHive.row: \(enemyHive.row)")
            enemyHives.append(enemyHive)
        }
    }
    
    func checkEnemyHiveTileClash(_ enemyHive: EnemyHive) -> Bool{
        for existingEnemyHive in enemyHives {
            if existingEnemyHive.row == enemyHive.row && existingEnemyHive.column == enemyHive.column {
                return true
            }
        }
        if enemyHive.row == 0 && enemyHive.column == 0 {
            return true
        } else if enemyHive.row == 11 && enemyHive.column == 11 {
            return true
        }
        return false
    }
    
    func populateEnemyHive(_ numberOfBees: Int, _ enemyHive: EnemyHive) {
        numberOfBees.times {
            let bee = VestalCuckoo()
            addEnemyBee(bee, enemyHive)
        }

    }
    
    func addEnemyBee(_ bee: Bee, _ enemyHive: EnemyHive) {
        print(bee)
        enemyHive.bees.append(bee)
        bee.currentRow = enemyHive.row
        bee.currentColumn = enemyHive.column
      //  enemyHive.expandHive(enemyHive.bees.count, infoPane)
       // bee.sprite.position = hive.location
       // hive.pulse()
       // bee.fly(hive.location, flightSpeed(bee, bee.destination))
    }
    
    
    func controlEnemyHive(_ enemyHive: EnemyHive) {
        checkEnemyDefeat(enemyHive)
        for enemyBee in enemyHive.bees {
                switch enemyBee.inHive {
                case true:
                   continue
                default:
                    enemyBee.updatePollenCloud()
                    checkEnemyFlightPath(enemyBee, enemyHive)
                }
               
                }
        }
    
    func checkEnemyDefeat(_ enemyHive: EnemyHive) {
        if enemyHive.bees.isEmpty && enemyHive.discovered {
            infoPane.updateGameStatus("Enemy hive defeated")
            map.setTileGroup(tiles.meadow, forColumn: enemyHive.column, row: enemyHive.row)
            removeEnemyHive(enemyHive)
        }
    }
    
    func releaseEnemyBee(_ enemyBee: Bee, _ enemyHive: EnemyHive) {
        enemyHive.bees.rotateBees()
        let destination = map.centerOfTile(atColumn: hive.column, row: hive.row)
        enemyBee.setDestination(destination, hive.column, hive.row)
        map.addChild(enemyBee.sprite)
        enemyBee.sprite.setScale(1.6)
        enemyBee.sprite.position = enemyHive.location
        enemyBee.fly(enemyHive.location, flightSpeed(enemyBee, enemyBee.destination))
    }
    
    func checkEnemyFlightPath(_ enemyBee: Bee, _ enemyHive: EnemyHive) {
        let column = self.map.tileColumnIndex(fromPosition: enemyBee.sprite.position)
        let row = self.map.tileRowIndex(fromPosition: enemyBee.sprite.position)
        let tile = self.map.tileDefinition(atColumn: column, row: row)
        enemyBee.currentRow = row
        enemyBee.currentColumn = column
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
            checkPollination(enemyBee, column, row, enemyHive)
        case "hive":
            if !enemyBee.inCombat {
                stealPlayerPollen(enemyBee)
                enemyBee.flyHome(enemyHive.location, flightSpeed(enemyBee, enemyHive.location))
            }
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
    
    func activateEnemies(_ enemyHive: EnemyHive) {
        let launch = SKAction.run( {self.launchEnemy(enemyHive)} )
        let pauseLaunch = SKAction.wait(forDuration: 10)
        let launchSequence = SKAction.sequence([launch, pauseLaunch])
        self.run(SKAction.repeatForever(launchSequence))
    }
    
    
    func launchEnemy(_ enemyHive: EnemyHive) {
        if let enemyBee = enemyHive.bees.first(where: { $0.inHive == true} ) {
                releaseEnemyBee(enemyBee, enemyHive)
            }
        }
    
    func removeEnemyHive(_ enemyHive: EnemyHive) {
        if let enemyIndex = enemyHives.firstIndex(where: {$0.id == enemyHive.id}) {
        enemyHives.remove(at: enemyIndex)
    }
     }

}
