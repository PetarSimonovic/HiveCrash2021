//
//  Flower.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 26/05/2021.
//

import Foundation
import SpriteKit


class Flower {
    
    // add subclasses for different flower types, with variance in pollent etc
    
    var location: CGPoint
    var column: Int
    var row: Int
    var pollen: Int
    var node: SKNode
    var particleNode: SKEmitterNode
    
    
    init(_ location: CGPoint, _ row: Int, _ column: Int) {
        self.location = location
        self.row = row
        self.column = column
        self.node = SKNode()
        self.particleNode = SKEmitterNode()
        self.pollen = 10
        addFlowerParticles()
    }
    
    func addFlowerParticles() {
        self.particleNode = SKEmitterNode(fileNamed: "hollyhock")!
        node.addChild(self.particleNode)
        
    }
    
}
