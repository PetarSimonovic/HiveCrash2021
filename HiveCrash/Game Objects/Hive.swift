//
//  Hive.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 25/05/2021.
//

import Foundation
import SpriteKit

class Hive {
    
    var isPlaced: Bool
    var column: Int
    var row: Int
    var location = CGPoint()
    var node: SKNode
    var pollen: Int = 0
    var pollenCount: Int
    
    init() {
        self.isPlaced = false
        self.column = 0
        self.row = 0
        self.location = CGPoint(x: 0, y: 0)
        self.pollen = 0
        self.node = SKNode()
        self.pollenCount = 1
        
    }

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
        bee.pollen = 0
    }
    

    
    
}


