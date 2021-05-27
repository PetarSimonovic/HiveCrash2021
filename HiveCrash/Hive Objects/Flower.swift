//
//  Flower.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 26/05/2021.
//

import Foundation
import SpriteKit


class Flower {
    
    // add subclasses for different flower types, with variance in pollent etc
    
    var location: CGPoint
    var column: Int
    var row: Int
    var pollen: Int
    var sprite: SKSpriteNode
    var particleNode: SKEmitterNode
    
    
    init(_ location: CGPoint,_ column: Int, _ row: Int) {
        self.location = location
        self.row = row
        self.column = column
        self.sprite = SKSpriteNode()
        self.particleNode = SKEmitterNode()
        self.pollen = 10
     //   createFlower()
    }
    
    func createFlower() {
        self.sprite = SKSpriteNode(imageNamed: "meadow")
        self.sprite.physicsBody = SKPhysicsBody(texture: self.sprite.texture!, size: self.sprite.size)
        self.sprite.name = "flower"
//        self.sprite.physicsBody?.categoryBitMask = CollisionBitMask.flowerCategory
//        self.sprite.physicsBody?.collisionBitMask = CollisionBitMask.beeCategory
//        self.sprite.physicsBody?.contactTestBitMask = CollisionBitMask.beeCategory
        self.sprite.physicsBody?.affectedByGravity = false
        self.sprite.physicsBody?.isDynamic = false
        self.sprite.zPosition = 0
        self.particleNode = SKEmitterNode(fileNamed: "hollyhock")!
     //   self.sprite.addChild(self.particleNode)
        
    }
    
}
