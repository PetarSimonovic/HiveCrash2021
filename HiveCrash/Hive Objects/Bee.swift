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
    
    init(_ destination: CGPoint, _ destinationRow: Int, _ destinationColumn: Int) {
        self.destination = destination
        self.destinationRow = destinationRow
        self.destinationColumn = destinationColumn
        
    }
    
    func createBee() -> SKSpriteNode {
     // Assign image and position
     let bee = SKSpriteNode(imageNamed: "bee")
     bee.physicsBody = SKPhysicsBody(texture: bee.texture!, size: bee.size)
 //    bee.setScale(scale)
     bee.name = "bee"
    // bee.physicsBody?.categoryBitMask = CollisionBitMask.seedCategory
    // bee.physicsBody?.collisionBitMask = CollisionBitMask.rockCategory | CollisionBitMask.canyonCategory
   //  bee.physicsBody?.contactTestBitMask = CollisionBitMask.rockCategory | CollisionBitMask.canyonCategory | CollisionBitMask.fireflyCategory
     bee.physicsBody?.affectedByGravity = false
     bee.physicsBody?.isDynamic = false
     bee.zPosition = 1
//     if let seedParticles = SKEmitterNode(fileNamed: "threadship") {
//         seedParticles.setScale(CGFloat(0.15))
//         seed.addChild(seedParticles)
//     }
     return bee
       
   }
 }
    
