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
        beeSprite.run(flight)

    }
    

}
