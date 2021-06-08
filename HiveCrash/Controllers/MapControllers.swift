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
                    let newTile = tiles.chooseTile()
                    map.setTileGroup(newTile, forColumn: column + tile[0], row: row + tile[1])
                    addMeadow(newTile, column + tile[0], row + tile[1])
                    addFlower(newTile, column + tile[0], row + tile[1])
                    adjustProgress()
                    }
                }
        default:
            let newTile = tiles.chooseTile()
            map.setTileGroup(newTile, forColumn: column, row: row)
            addMeadow(newTile, column, row)
            addFlower(newTile, column, row)
            adjustProgress()
        }
    }
    
    func addMeadow(_ tile: SKTileGroup, _ column: Int, _ row: Int) {
        if tile.name  == "meadow" {
            let meadow = Meadow(column, row)
            meadows.append(meadow)
        }
        
    }
    
    func adjustProgress() {
        tileCounter -= 1
        print(tileCounter)
        infoPane.updateGameStatus("\(tileCounter) tiles remaimning")
        if tileCounter <= 1 {
            levelComplete()
        }

    }
}
