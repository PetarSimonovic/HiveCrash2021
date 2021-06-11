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
    
    var id = UUID()
    var name: String

    
    var destination: CGPoint = CGPoint(x: 0, y: 0)
    var destinationRow: Int = 0
    var destinationColumn: Int = 0
    
    var speed: Int = 300
    var pollen: Int = 0
    var pollenCapacity: Int = 10
    var appetite: Int = 5
    var startHealth: Int = 5
    var maxHealth: Int = 10
    var health: Int
    
    
    var homewardBound: Bool = false
    var pollenCollecting: Bool = false
    var inHive: Bool = true
    var settler: Bool = false
    var scout: Bool = false
    
    var sprite = SKSpriteNode()
    var pollenCloud = SKEmitterNode ()
    
    init() {
        self.name = chooseName()
        self.health = self.startHealth
        self.createBee()
    }
    
    func createBee() {
        self.sprite = SKSpriteNode(imageNamed: "bee")
        self.sprite.physicsBody = SKPhysicsBody(texture: self.sprite.texture!, size: self.sprite.size)
        self.sprite.name = "\(self.id)"
        self.sprite.physicsBody?.affectedByGravity = false
        self.sprite.physicsBody?.isDynamic = false
        self.sprite.zPosition = 2
        self.pollenCloud = SKEmitterNode(fileNamed: "BeePollen")!
        self.sprite.addChild(self.pollenCloud)
        self.pollenCloud.particleBirthRate = CGFloat(self.pollen)
   }
    
    func fly(_ hiveLocation: CGPoint, _ beeSpeed: TimeInterval) {
        self.inHive = false
        self.pollenCollecting = false
        let flight = SKAction.move(to: self.destination, duration: beeSpeed)
        let flyHome = SKAction.run ( { self.flyHome(hiveLocation, beeSpeed)} )
        let flightPath = SKAction.sequence([flight, flyHome])
        self.sprite.run(flightPath, withKey: "flightPath")
    }
    
    
    func setDestination(_ destination: CGPoint, _ column: Int, _ row: Int) {
        self.destination = destination
        self.destinationColumn = column
        self.destinationRow = row
    }
    
    func flyHome(_ destination: CGPoint, _ beeSpeed: TimeInterval ) {
        if self.homewardBound == false && self.scout == true {
            self.settler = true
//            let waggleDance = SKAction.rotate(byAngle: 10, duration: 0.5)
//            self.sprite.run(SKAction.repeatForever(waggleDance))
        } else if self.homewardBound == false {
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
        self.sprite.removeFromParent()
        self.sprite.removeAllChildren()
        self.sprite.position = CGPoint(x: 0, y: 0)
        self.inHive = true
        self.homewardBound = false
        self.pollenCollecting = false
        self.pollen = 0
        self.scout = false
        self.settler = false


    }
    
    
        
    func collectPollen(_ flower: Flower, _ hive: CGPoint,_ beeSpeed: TimeInterval) {
     //   if flower.inBloom {
        // exrract the collection into its own class?
//        print("BEE POLLEN", self.pollen)
//        print("FLOWER POLLEN", flower.pollen)
        self.sprite.removeAction(forKey: "flightPath")
        self.sprite.removeAction(forKey: "flyHome")
        self.sprite.run(SKAction.repeatForever(SKAction.rotate(byAngle: 10, duration: 0.5)))
        self.sprite.run(SKAction.move(to: flower.location, duration: 1))
     //   } else {
   //         homewardBound ? self.sprite.run(SKAction.move(to: hive, duration: beeSpeed)) : self.sprite.run(SKAction.move(to: self.destination, duration: beeSpeed))

    //    }
       

    }
           
 }
    
