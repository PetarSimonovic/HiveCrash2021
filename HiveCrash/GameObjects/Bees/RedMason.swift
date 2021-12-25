//
//  RedMason.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 12/06/2021.
//

import Foundation
import SpriteKit

class RedMason : Bee {
    
    override init() {
     super.init()
     self.type = "Red Mason"
     self.speed = self.defaultSpeed - 300
     self.maxPollen = 50
     self.appetite = 10
     self.maxHealth = 5
     self.health = self.maxHealth
     self.maxRange = 2
     self.range = self.maxRange
     self.sprite = SKSpriteNode(imageNamed: "redmason")
    
}

}
