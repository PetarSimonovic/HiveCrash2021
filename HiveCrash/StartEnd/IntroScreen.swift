//
//  IntroScreen.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 24/07/2021.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func startDemo() {
        chooseIntroHiveLocation()
        startIntroSequence()
        createEternalHive()
        
    }
    
    func chooseIntroHiveLocation() {
        let column = randomNumber(12)
        let row = randomNumber(12)
        let CG = map.centerOfTile(atColumn: column, row: row)
        placeHive(CG, column, row)
    }
    
    func randomNumber(_ num: Int) -> Int {
        return Int.random(in: 1..<num)
    }
    
    func startIntroSequence() {
        let launchDelay = SKAction.wait(forDuration: 5)
        let launchIntroBees = SKAction.run({ self.launchIntroBees() })
        let introSequence = SKAction.sequence([launchDelay, launchIntroBees])
        self.run(SKAction.repeatForever(introSequence))

    }
    
    func createEternalHive() {
        for savedBee in eternalHive {
            switch savedBee.type {
            case "Common Carder":
                let bee = CommonCarder()
                setBeeProperties(bee, savedBee)
            case "Red Mason":
                let bee = RedMason()
                setBeeProperties(bee, savedBee)
            case "Leaf Cutter":
                let bee = LeafCutter()
                setBeeProperties(bee, savedBee)
            default:
                continue

                        }
            
        }
    }
    
    func setBeeProperties(_ bee: Bee, _ savedBee: SavedBee) {
        bee.name = savedBee.name
        bee.id = savedBee.id
        hive.bees.append(bee)
        print("Hive intro bees", hive.bees)
    }
    
    func launchIntroBees() {
        if let bee = hive.bees.first(where: {$0.inHive == true} ) {
        let row = randomNumber(12)
        let column = randomNumber(12)
        releaseBee(bee, column, row)
        }
    }

    
}
