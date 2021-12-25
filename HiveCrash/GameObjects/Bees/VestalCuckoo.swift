//
//  Enem.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 14/06/2021.
//

import Foundation
import SpriteKit

class VestalCuckoo : Bee {
    
    override init() {
     super.init()
     self.type = "Vestal Cuckoo"
     self.speed = self.defaultSpeed
     self.maxPollen = 30
     self.appetite = 10
     self.maxHealth = 5
     self.attack = 5
     self.health = self.maxHealth
     self.maxRange = 7
     self.range = self.maxRange
     self.sprite = SKSpriteNode(imageNamed: "enemyBee")
     self.currentRow = 2000
     self.currentColumn = 2000
    // self.createBee()
 }
    
   override func removeBee() {
        self.sprite.removeFromParent()
        self.sprite.removeAllChildren()
        self.sprite.removeAllActions()
        self.sprite.position = CGPoint(x: 1000, y: 1000)
        self.inHive = true
        self.homewardBound = false
        self.pollenCollecting = false
        self.pollen = 0
        self.scout = false
        self.settler = false
        self.range = self.maxRange
        self.currentColumn = 2000
        self.currentRow = 2000
        self.inCombat = false
    }
    
}
