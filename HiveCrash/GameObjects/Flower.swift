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
    var pollen: Int = 100
    var sprite = SKSpriteNode()
    var particleNode = SKEmitterNode()
    var inBloom: Bool = false
    var growthSpeed: TimeInterval = 10
    var hasBee: Bool = false
    
    
    init(_ location: CGPoint,_ column: Int, _ row: Int) {
        self.location = location
        self.row = row
        self.column = column
        grow()

//        createFlower()

    }
    
    func grow() {
        let growthTimer = SKAction.wait(forDuration: growthSpeed)
        let witherTimer = SKAction.wait(forDuration: 5)
        let bloom = SKAction.run({ self.bloom() })
        let wither = SKAction.run({self.wither() })
        let removeFlower = SKAction.run({self.removeFlower()})
        let growthCycle = SKAction.sequence([growthTimer, bloom, growthTimer, wither, witherTimer, removeFlower])
        self.sprite.run(SKAction.repeatForever(growthCycle))
    }
    
    func bloom() {
        self.inBloom = true
        let bloomNode = SKEmitterNode(fileNamed: "hollyhock")!
        self.sprite.addChild(bloomNode)
        
    }
    
    func wither() {
       // print("Dying!")
        self.inBloom = false
        let witherNode = SKEmitterNode(fileNamed: "hollyhockDisperse")!
        self.sprite.zPosition = 1.5
        witherNode.advanceSimulationTime(3)
        self.sprite.removeAllChildren()
        self.sprite.addChild(witherNode)
        self.pollen = 100
        
    }
    
    func removeFlower() {
        self.sprite.removeAllChildren()
    }
    
}
