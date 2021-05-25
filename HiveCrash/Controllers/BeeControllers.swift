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
        print("Bee destination:", bee.destination)
        print("column, row:", bee.destinationColumn, bee.destinationRow)
        map.setTileGroup(tiles.chooseTile(), forColumn: column, row: row)
        print("Bee added")
    }
    
    
}
