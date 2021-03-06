//
//  Hive.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 25/05/2021.
//

import Foundation
import SpriteKit

class Hive {
    
    var isPlaced: Bool = false
    var column: Int = 0
    var row: Int = 0
    var location: CGPoint = CGPoint(x: 0, y: 0)
    var node = SKNode ()
    var pollen: Int = 50
    var pollenCount: Int = 1
    var firstFlowerMeadow: Bool = false
    var maxPollen: Int = 150
    var moveCost: Int = 100
    var bees: [Bee] = []

    func place(_ location: CGPoint, _ column: Int, _ row: Int) {
        self.node.removeFromParent()
        print("Hive placed at", column, row)
        isPlaced = true
        self.column = column
        self.row = row
        self.location = location
        self.node.position = location
    }
    
    
    
    func pulse() {
        let pulseNode = SKEmitterNode(fileNamed: "HivePulse")!
        let addEmitterAction = SKAction.run({self.node.addChild(pulseNode)})
        let emitterDuration = Double(pulseNode.numParticlesToEmit) / Double(pulseNode.particleBirthRate) + Double(pulseNode.particleLifetime + pulseNode.particleLifetimeRange/2)
        let wait = SKAction.wait(forDuration: TimeInterval(emitterDuration))
        let remove = SKAction.run( {pulseNode.removeFromParent()} )
        let pulseSequence = SKAction.sequence([addEmitterAction, wait, remove])
        self.node.run(pulseSequence)
    
    }
    
    func updatePollen(_ bee: Bee) {
        self.pollen += bee.pollen
        if self.pollen > self.maxPollen {
            self.pollen = self.maxPollen
        }
        bee.pollen = 0
    }
    
    func checkNoPollen() {
        if self.pollen < 0 {
            self.pollen = 0
        }
    }
    
    func expandHive(_ bees: Int, _ infoPane: InfoPane) {
        if bees % 5 == 0 {
            self.maxPollen += 25
            infoPane.updateGameStatus("Hive pollen capacity expanded to \(self.maxPollen)")
        }
    }
    
    func reset() {
        self.isPlaced = false
        self.column = 0
        self.row = 0
        self.location = CGPoint(x: 0, y: 0)
        self.firstFlowerMeadow = false
        bringBeesHome()
       
    }
    
    func bringBeesHome() {
        for bee in self.bees {
            bee.removeBee();
        }
    }
    
    func allBeesHome() -> Bool {
        for bee in self.bees {
            if !bee.inHive {
                return false
            }
        }
        return true;
    }


    
    
}


