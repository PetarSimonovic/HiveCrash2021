//
//  Hive.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 25/05/2021.
//

import Foundation
import SpriteKit

class Hive {
    
    var isPlaced: Bool = false
    var column: Int = 0
    var row: Int = 0
    var location = CGPoint()
    var node = SKNode()
    var pollen: Int = 0

    func place(_ location: CGPoint, _ column: Int, _ row: Int) {
        self.node.removeFromParent()
        print("Hive placed at", column, row)
        isPlaced = true
        self.column = column
        self.row = row
        self.location = location
        self.node.position = location
    }
    
    func pulse() {
        let pulseNode = SKEmitterNode(fileNamed: "HivePulse")!
        self.node.addChild(pulseNode)
    }
    
    func updatePollen(_ bee: Bee) {
        self.pollen += bee.pollen
        bee.pollen = 0
    }
    
    
}


