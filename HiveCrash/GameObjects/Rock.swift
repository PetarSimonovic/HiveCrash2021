//
//  Rock.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 25/05/2021.
//

import Foundation
import SpriteKit

class Rock {
    
    // initalise this bee with some properties? Worker, drone etc? Then make newBee an instance of bee?
    
    var location: CGPoint
    var sprite: SKSpriteNode
    
    init(_ location: CGPoint) {
        self.location = location
        self.sprite = SKSpriteNode()
        self.createRock()
    }
    
    func createRock() {
     // Assign image
        self.sprite = SKSpriteNode(imageNamed: "rock")
        self.sprite.physicsBody = SKPhysicsBody(texture: self.sprite.texture!, size: self.sprite.size)
        self.sprite.name = "rock"
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
