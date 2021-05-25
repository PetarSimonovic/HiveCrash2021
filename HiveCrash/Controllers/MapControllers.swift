//
//  MapControllers.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 25/05/2021.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func clearFog(_ column: Int, _ row: Int, _ hive: Bool) {
        
        switch hive {
        case true:
            let adjacentTiles = tiles.getTiles(column % 2)
            for tile in adjacentTiles {
                let checkTile = map.tileDefinition(atColumn: column + tile[0], row: row + tile[1])
                    if let _ = checkTile?.userData?.value(forKey: "fog") {
                    map.setTileGroup(tiles.chooseTile(), forColumn: column + tile[0], row: row + tile[1]  )
            }
        }
        default:
            map.setTileGroup(tiles.chooseTile(), forColumn: column, row: row)
        }
    }
    
   
        

    
}
