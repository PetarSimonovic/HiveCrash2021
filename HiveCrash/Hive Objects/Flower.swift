//
//  Flower.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 26/05/2021.
//

import Foundation
import SpriteKit


class Flower {
    
    // add subclasses for different flower types, with variance in pollent, growthSpeed etc
    
    var location: CGPoint
    var column: Int
    var row: Int
    var pollen: Int
    var sprite: SKSpriteNode
    var particleNode: SKEmitterNode
    var inBloom: Bool
    var growthSpeed: TimeInterval
    
    
    init(_ location: CGPoint,_ column: Int, _ row: Int) {
        self.location = location
        self.row = row
        self.column = column
        self.sprite = SKSpriteNode()
        self.particleNode = SKEmitterNode()
        self.pollen = 100
        self.inBloom = false
        self.growthSpeed = 10
        grow()

//        createFlower()

    }
    
    func grow() {
        let growthTimer = SKAction.wait(forDuration: growthSpeed)
        let bloom = SKAction.run({ self.bloom() })
        let wither = SKAction.run({self.wither() })
        let growthCycle = SKAction.sequence([growthTimer, bloom, growthTimer, wither])
        self.sprite.run(SKAction.repeatForever(growthCycle))
    }
    
    func bloom() {
        print("Flower is in bloom!", self.pollen)
        self.inBloom = true
        let bloomNode = SKEmitterNode(fileNamed: "hollyhock")!
        self.sprite.addChild(bloomNode)
        
    }
    
    func wither() {
       // print("Dying!")
        self.inBloom = false
        let witherNode = SKEmitterNode(fileNamed: "hollyhockDisperse")!
        witherNode.advanceSimulationTime(3)
        self.sprite.removeAllChildren()
        self.sprite.addChild(witherNode)
        self.pollen = 100
        
    }
    
}
