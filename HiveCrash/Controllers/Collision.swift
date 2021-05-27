////
////  Collision.swift
////  HiveCrash
////
////  Created by Petar Simonovic on 26/05/2021.
////
//
//import Foundation
//import SpriteKit
//
//struct CollisionBitMask {
//    static let beeCategory:UInt32 = 0x1 << 0
//    static let flowerCategory:UInt32 = 0x1 << 1
//
//}
//
//extension GameScene {
//    
//    
//   func didBegin(_ contact: SKPhysicsContact) {
//        let firstBody = contact.bodyA
//        let secondBody = contact.bodyB
//        
//        if firstBody.categoryBitMask == CollisionBitMask.flowerCategory && secondBody.categoryBitMask == CollisionBitMask.beeCategory || firstBody.categoryBitMask == CollisionBitMask.beeCategory && secondBody.categoryBitMask == CollisionBitMask.flowerCategory  {
//            print("Bee on flower")
//            }
//    }
//    
//}
//
