//
//  CommonCarder.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 12/06/2021.
//

import Foundation
import SpriteKit


class CommonCarder : Bee {
    
   override init() {
    super.init()
    self.type = "Common Carder"
    self.speed = 300
    self.pollenCapacity = 30
    self.appetite = 10
    self.maxHealth = 5
    self.health = self.maxHealth
    self.maxRange = 3
    self.range = self.maxRange
    self.sprite = SKSpriteNode(imageNamed: "commoncarder")

   // self.createBee()
}
}
