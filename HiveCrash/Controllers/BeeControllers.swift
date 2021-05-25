//
//  BeeControllers.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 25/05/2021.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func addBee(_ location: CGPoint, _ column: Int, _ row: Int) {
        let bee = Bee(location, column, row)
        let beeSprite = bee.createBee()
        map.addChild(beeSprite)
        beeSprite.position = hive.location
        map.setTileGroup(tiles.chooseTile(), forColumn: column, row: row)
        let flight = SKAction.move(to: bee.destination, duration: 10)
        let flyHome = SKAction.move(to: hive.location, duration: 10)
        let flightPath = SKAction.sequence([flight, flyHome])
        beeSprite.run(flightPath)
    }
    
    func beeFlight() {
    
        map.enumerateChildNodes(withName: "bee", using: ({
        (node, error) in
        let bee = node as! SKSpriteNode
        print(bee)
        let column = self.map.tileColumnIndex(fromPosition: bee.position)
        let row = self.map.tileRowIndex(fromPosition: bee.position)
        print("TILE:", column, row)
        let tile = self.map.tileDefinition(atColumn: column, row: row)
        if let _ = tile?.userData?.value(forKey: "fog") {
            self.clearFog(column, row, false)
        }
        }))
    }
    

}
