//
//  Bee.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 25/05/2021.
//

import Foundation
import SpriteKit

class Bee {
    
    // initalise this bee with some properties? Worker, drone etc? Then make newBee an instance of bee?
    
    var destination: CGPoint
    var destinationRow: Int
    var destinationColumn: Int
    var speed: Int
    var sprite: SKSpriteNode
    var id = UUID()
    var pollen: Int
    var pollenCapacity: Int
    var homewardBound: Bool = false
    
    init(_ destination: CGPoint, _ destinationRow: Int, _ destinationColumn: Int) {
        self.destination = destination
        self.destinationRow = destinationRow
        self.destinationColumn = destinationColumn
        self.speed = 300
        self.sprite = SKSpriteNode()
        self.pollen = 0
        self.pollenCapacity = 10
        self.createBee()
    }
    
    func createBee() {
     // Assign image
        self.sprite = SKSpriteNode(imageNamed: "bee")
        self.sprite.physicsBody = SKPhysicsBody(texture: self.sprite.texture!, size: self.sprite.size)
        self.sprite.name = "bee"
    // bee.physicsBody?.categoryBitMask = CollisionBitMask.seedCategory
    // bee.physicsBody?.collisionBitMask = CollisionBitMask.rockCategory | CollisionBitMask.canyonCategory
   //  bee.physicsBody?.contactTestBitMask = CollisionBitMask.rockCategory | CollisionBitMask.canyonCategory | CollisionBitMask.fireflyCategory
        self.sprite.physicsBody?.affectedByGravity = false
        self.sprite.physicsBody?.isDynamic = false
        self.sprite.zPosition = 1
//     if let seedParticles = SKEmitterNode(fileNamed: "threadship") {
//         seedParticles.setScale(CGFloat(0.15))
//         seed.addChild(seedParticles)
//     }
      //  return self.beeSprite
   }
 }
    
