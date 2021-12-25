//
//  BeeControllers.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 25/05/2021.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func addBee(_ bee: Bee) {
        
        print(bee)
        hive.bees.append(bee)
        bee.currentRow = hive.row
        bee.currentColumn = hive.column
        hive.expandHive(hive.bees.count, infoPane)
        if !intro { saveBee(bee) }
       // bee.sprite.position = hive.location
       // hive.pulse()
       // bee.fly(hive.location, flightSpeed(bee, bee.destination))
    }
    
    func releaseBee(_ bee: Bee, _ column: Int, _ row: Int) {
        hive.bees.rotateBees()
        let destination = map.centerOfTile(atColumn: column, row: row)
        bee.setDestination(destination, column, row)
        map.addChild(bee.infoPane)
        map.addChild(bee.sprite)
        bee.sprite.position = hive.location
        bee.sprite.setScale(1.6)
        bee.infoPane.setScale(UIScreen.main.bounds.width * 0.01)
        bee.fly(hive.location, flightSpeed(bee, bee.destination))
        if tutorial.on && tutorial.status == "flight" {tutorial.updateStatus() }
        infoPane.updateGameStatus("\(bee.name) has left the hive")
        updateSavedBee(bee.id, "flights", 1)
    }
    

    
    func migrateBees (_ oldHive: CGPoint, _ newHive: CGPoint, _ column: Int, _ row: Int) {
        migration = true
        for bee in hive.bees {
            if bee.settler == false {
              bee.removeBee()
              infoPane.updateGameStatus("\(bee.name) is migrtating")
              if bee.scout == false {
                bee.inHive = false
                bee.destination = newHive
                bee.destinationColumn = column
                bee.destinationRow = row
                map.addChild(bee.sprite)
                bee.sprite.position = oldHive
                bee.flyHome(newHive, flightSpeed(bee, newHive))
            } 
        }
        infoPane.updateGameStatus("Hive migrated")
        scouting = false
    }
    }
        
        func checkMigration() {
            for bee in hive.bees {
              if bee.inHive == false { return }
            }
            migration = false
            removeBees()
        }

    
    func beeFlight() {
        for bee in hive.bees {
            bee.updatePollenCloud()
            switch bee.inHive {
            case false:
                checkFlightPath(bee)
            default:
                continue
            }
           
            }
    }
    
    
    func checkFlightPath(_ bee: Bee) {
        if migration == true { return }
        let column = self.map.tileColumnIndex(fromPosition: bee.sprite.position)
        let row = self.map.tileRowIndex(fromPosition: bee.sprite.position)
        let tile = self.map.tileDefinition(atColumn: column, row: row)
                       // print("Bee tile", column, row)
        checkCombat(bee)

       // NO LONGER CHECKING FOR RANGE - CURRENTROW/COLUMN UPDATED GHERE
       // checkDistanceFlown(bee, column, row)
        bee.currentColumn = column
        bee.currentRow = row
        if bee.settler {
           newHive(bee)
        }
        switch tile?.name! {
        case "fog":
             clearFog(column, row, false)
        case "lake":
            if  bee.pollen != 0 {
             let pollenLoss =  bee.pollen - (bee.speed/10) / 2
                bee.pollen -= pollenLoss
                infoPane.updateGameStatus("\(bee) shed \(pollenLoss) over Lake: \(bee.pollen)")
            }
        case "rock":
            if bee.scout {
                infoPane.updateGameStatus("No clear path to meadow - select new location")
                bee.scout = false
                moveHive = false
                scouting = false
            }
            bee.flyHome(hive.location, flightSpeed(bee, hive.location))
        case "meadow":
            if bee.pollen != 0 {
              shedPollen(bee, column, row)
            }
        case "flowerMeadow":
            checkPollination(bee, column, row, hive)
        case "hive":
            if bee.homewardBound == true {
            hive.pulse()
            infoPane.updateGameStatus("\(bee.name) added \(bee.pollen) to hive")
            hive.updatePollen(bee)
            bee.homewardBound = false
                if tutorial.on && tutorial.status == "pollen" || tutorial.on && tutorial.status == "conditions" {
                    tutorial.updateStatus()
                }
              //  hive.bees.rotateBees()
            infoPane.updateGameStatus("\(bee.name) has returned to the hive")
            } else {
                hive.pulse()
            }
        case "enemyHive":
            if !bee.inCombat {stealEnemyPollen(bee, column, row)}
        default:
            return
        }
    }
    
    func beeEats(_ bee: Bee) {
        if bee.health < bee.maxHealth {
            bee.health  += 1
        }
        infoPane.updateGameStatus("\(bee.name) has eaten. Health is now \(bee.health)")
       }
    
     
    
    func beeStarves(_ bee: Bee) {
        if !intro {
        bee.health -= 1
        infoPane.updateGameStatus("Not enough food for \(bee.name)")
        checkHealth(bee, hive)
        }
       }
    
    func killBee(_ bee: Bee, _ hive: Hive) {
        if let beeIndex = hive.bees.firstIndex(where: {$0.id == bee.id}) {
        hive.bees.remove(at: beeIndex)
        infoPane.updateGameStatus("\(bee.name) died")
            print("\(bee.name), \(bee.type) died")
        bee.removeBee()
        gameOver()
        }
     }
    
    func hatchBee(_ bee: Bee) {
        if hive.pollen >= beeCost {
           hive.pollen -= beeCost
           addBee(bee)
        } else {
            infoPane.updateGameStatus("Not enough pollen to create a bee")
        }
    }
    
    func checkDistanceFlown(_ bee: Bee, _ column: Int, _ row: Int) {
        if bee.currentColumn != column || bee.currentRow != row {
            bee.currentColumn = column
            bee.currentRow = row
        }
    }
    
    func rangeReached(_ bee: Bee) {
        if bee.range < 0 {
            if bee.scout {
                bee.settler = true
                bee.settle()
                bee.setDestination(bee.sprite.position, bee.currentColumn, bee.currentRow)
                newHive(bee)
            }
            
            infoPane.updateGameStatus("Destiantion is out of range for \(bee.name)")
            bee.flyHome(hive.location, flightSpeed(bee, hive.location))
        }
    }
    
    func populateHive(_ numberOfBees: Int, _ player: Bool) {
        if player {
            numberOfBees.times {
            let bee = CommonCarder()
            addBee(bee)
            infoPane.updateGameStatus("\(bee.name) has joined the hive")
            
            }
            } else {
                numberOfBees.times {
                let bee = VestalCuckoo()
                addBee(bee)
                }
            }
    }
    
    func resetBees() {
        for bee in hive.bees {
            bee.health = bee.maxHealth
        }
    }
        
        func removeBees() {
            for bee in hive.bees {
                bee.removeBee()
            }
        }
    
    func checkHealth(_ bee: Bee, _ hive: Hive) {
        if bee.health <= 0 {
           killBee(bee, hive)
        }
    }
    
    func stealPlayerPollen(_ enemyBee: Bee) {
        print("Enemy is stealing pollen")
        var stolenPollen = 0
        if hive.pollen - enemyBee.maxPollen <= 0 {
            stolenPollen = hive.pollen
            hive.pollen = 0
            enemyBee.pollen += stolenPollen
        } else {
            stolenPollen = hive.pollen - enemyBee.maxPollen
            hive.pollen -= enemyBee.maxPollen
            enemyBee.pollen += stolenPollen
        }
        infoPane.updateGameStatus("\(enemyBee.name) stole \(stolenPollen)")
        hive.checkNoPollen()

    }
    
    func stealEnemyPollen(_ bee: Bee, _ column: Int, _ row: Int) {
        let enemyHive = getEnemyHive(column, row)
        print("player is stealing pollen")
        var stolenPollen = 0
        if enemyHive.pollen - bee.maxPollen <= 0 {
            stolenPollen = enemyHive.pollen
            enemyHive.pollen = 0
            bee.pollen += stolenPollen
        } else {
            stolenPollen = enemyHive.pollen - bee.maxPollen
            enemyHive.pollen -= bee.maxPollen
            bee.pollen += stolenPollen
        }
        infoPane.updateGameStatus("\(bee.name) stole \(stolenPollen)")
        hive.checkNoPollen()

    }
    
    func getEnemyHive(_ column: Int, _ row: Int ) -> EnemyHive {
        let enemyHive = enemyHives.firstIndex(where: {$0.column == column && $0.row == row})!
        return enemyHives[enemyHive]
    }
    
    func limitPollenToMaxPollen(_ bee: Bee) {
        if bee.pollen > bee.maxPollen { bee.pollen = bee.maxPollen }
    }

    
    
//    func debugInfo(_ bee: Bee) {
//        if bee.inHive == false {
//            print(bee.name)
//            print("Scout", bee.scout)
//            print("Settler", bee.settler)
//            print("Current", bee.currentColumn, bee.currentRow)
//            print("Destination", bee.destinationColumn, bee.destinationRow)
//            print("HomewardBound", bee.homewardBound)
//            print("HomewardBound", bee.inCombat)
//
//
//
//
//        }
//    }
    
}
