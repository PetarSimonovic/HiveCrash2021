//
//  LeafCutter.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 12/06/2021.
//

import Foundation
import SpriteKit

class LeafCutter : Bee {
        
    override init() {
         super.init()
         self.type = "Leaf Cutter"
        self.speed = self.defaultSpeed + 400
        self.attack = 7
         self.maxPollen = 15
         self.appetite = 10
         self.maxHealth = 5
         self.health = self.maxHealth
         self.maxRange = 11
         self.range = self.maxRange
         self.sprite = SKSpriteNode(imageNamed: "leafcutter")
        
    }
}
