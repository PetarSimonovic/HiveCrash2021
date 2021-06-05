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
    var homewardBound: Bool
    var pollenCollecting: Bool
    var inHive: Bool
    var pollenCloud: SKEmitterNode

    
    init(_ destination: CGPoint, _ destinationRow: Int, _ destinationColumn: Int) {
        self.destination = destination
        self.destinationRow = destinationRow
        self.destinationColumn = destinationColumn
        self.speed = 300
        self.sprite = SKSpriteNode()
        self.pollenCloud = SKEmitterNode()
        self.pollen = 0
        self.pollenCapacity = 10
        self.pollenCollecting = false
        self.homewardBound = false
        self.inHive = false
        self.createBee()
    }
    
    func createBee() {
        self.sprite = SKSpriteNode(imageNamed: "bee")
        self.sprite.physicsBody = SKPhysicsBody(texture: self.sprite.texture!, size: self.sprite.size)
        self.sprite.name = "bee"
        self.sprite.physicsBody?.affectedByGravity = false
        self.sprite.physicsBody?.isDynamic = false
        self.sprite.zPosition = 1
        self.pollenCloud = SKEmitterNode(fileNamed: "BeePollen")!
        self.sprite.addChild(self.pollenCloud)
        self.pollenCloud.particleBirthRate = CGFloat(self.pollen)
   }
    
    func fly(_ hiveLocation: CGPoint, _ beeSpeed: TimeInterval) {
        self.pollenCollecting = false
        let flight = SKAction.move(to: self.destination, duration: beeSpeed)
        let flyHome = SKAction.run ( { self.flyHome(hiveLocation, beeSpeed)} )
        let flightPath = SKAction.sequence([flight, flyHome])
        self.sprite.run(flightPath, withKey: "flight")
    }
    
    func flyHome(_ destination: CGPoint, _ beeSpeed: TimeInterval ) {
        if self.homewardBound == false {
            self.sprite.removeAllActions()
            let removeBee = SKAction.run( { self.removeBee() } )
            let flyHome = SKAction.move(to: destination, duration: beeSpeed)
            let returnToHive = SKAction.sequence([flyHome, removeBee])
            self.sprite.run(returnToHive, withKey: "flyHome")
            self.homewardBound = true
        }
         self.pollenCollecting = false
    }
    
    func removeBee() {
       // self.inHive == true
        self.sprite.removeFromParent()
        self.sprite.position = CGPoint(x: 0, y: 0)
    }
    
        
    func collectPollen(_ flower: Flower, _ hive: CGPoint,_ beeSpeed: TimeInterval) {
     //   if flower.inBloom {
        // exrract the collection into its own class?
//        print("BEE POLLEN", self.pollen)
//        print("FLOWER POLLEN", flower.pollen)
        self.sprite.removeAction(forKey: "flight")
        self.sprite.removeAction(forKey: "flyHome")
        self.sprite.run(SKAction.rotate(byAngle: 10, duration: 0.5))
        self.sprite.run(SKAction.move(to: flower.location, duration: 1))
     //   } else {
   //         homewardBound ? self.sprite.run(SKAction.move(to: hive, duration: beeSpeed)) : self.sprite.run(SKAction.move(to: self.destination, duration: beeSpeed))

    //    }
       

    }
           
 }
    
