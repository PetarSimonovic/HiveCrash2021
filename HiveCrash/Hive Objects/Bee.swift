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
        self.sprite = SKSpriteNode(imageNamed: "bee")
        self.sprite.physicsBody = SKPhysicsBody(texture: self.sprite.texture!, size: self.sprite.size)
        self.sprite.name = "bee"
        self.sprite.physicsBody?.affectedByGravity = false
        self.sprite.physicsBody?.isDynamic = false
        self.sprite.zPosition = 1
   }
    
    func fly(_ hiveLocation: CGPoint, _ beeSpeed: TimeInterval) {
        let flight = SKAction.move(to: self.destination, duration: beeSpeed)
        let flyHome = SKAction.run ( { self.flyHome(hiveLocation, beeSpeed)} )
        let flightPath = SKAction.sequence([flight, flyHome])
        self.sprite.run(flightPath)
    }
    
    func flyHome(_ destination: CGPoint, _ beeSpeed: TimeInterval ) {
        print("Now in BEE CLASS")
        self.sprite.removeAllActions()
        let removeBee = SKAction.run(self.sprite.removeFromParent)
        let flyHome = SKAction.move(to: destination, duration: beeSpeed)
        let returnToHive = SKAction.sequence([flyHome, removeBee])
        self.sprite.run(returnToHive)
        self.homewardBound = true
    }
 }
    
