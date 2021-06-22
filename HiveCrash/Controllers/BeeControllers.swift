//
//  BeeControllers.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 25/05/2021.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func addBee(_ bee: Bee, _ hive: Hive) {
        
        print(bee)
        hive.bees.append(bee)
        bee.currentRow = hive.row
        bee.currentColumn = hive.column
        hive.expandHive(hive.bees.count, infoPane)
       // bee.sprite.position = hive.location
       // hive.pulse()
       // bee.fly(hive.location, flightSpeed(bee, bee.destination))
    }
    
    func releaseBee(_ bee: Bee, _ column: Int, _ row: Int) {
        hive.bees.rotateBees()
        let destination = map.centerOfTile(atColumn: column, row: row)
        bee.setDestination(destination, column, row)
        map.addChild(bee.sprite)
        bee.sprite.position = hive.location
        bee.sprite.setScale(0.93)
        bee.fly(hive.location, flightSpeed(bee, bee.destination))
        infoPane.updateGameStatus("\(bee.name) has left the hive")
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
              //  hive.bees.rotateBees()
            infoPane.updateGameStatus("\(bee.name) has returned to the hive")
            } else {
                hive.pulse()
            }
        case "enemyHive":
            stealPollen(bee, enemyHive)
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
        bee.health -= 1
        infoPane.updateGameStatus("Not enough food for \(bee.name)")
        checkHealth(bee, hive)
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
           addBee(bee, hive)
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
            addBee(bee, hive)
            infoPane.updateGameStatus("\(bee.name) has joined the hive")
            
            }
            } else {
                numberOfBees.times {
                let bee = VestalCuckoo()
                addBee(bee, enemyHive)
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
    
    func stealPollen(_ bee: Bee, _ hive: Hive) {
        var stolenPollen = 0
        if hive.pollen - bee.pollenCapacity <= 0 {
            stolenPollen = hive.pollen
            hive.pollen = 0
            bee.pollen += stolenPollen
        } else {
            stolenPollen = hive.pollen - bee.pollenCapacity
            hive.pollen -= bee.pollenCapacity
            bee.pollen += stolenPollen
        }
        infoPane.updateGameStatus("\(bee.name) stole \(stolenPollen)")
        hive.checkNoPollen()

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
