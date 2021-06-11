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
                    var newTile = tiles.chooseTile(level)
                        if newTile == tiles.flowerMeadow {
                            newTile = tiles.meadow
                        }
                    map.setTileGroup(newTile, forColumn: column + tile[0], row: row + tile[1])
                    addMeadow(newTile, column + tile[0], row + tile[1])
                    }
                checkVictory()
                }
        default:
            var newTile = SKTileGroup()
            if self.hive.firstFlowerMeadow == false {
                newTile = tiles.flowerMeadow
                self.hive.firstFlowerMeadow = true
                tiles.fogCount -= 1
            } else {
              newTile = tiles.chooseTile(level)
            }
            map.setTileGroup(newTile, forColumn: column, row: row)
            addMeadow(newTile, column, row)
            addFlower(newTile, column, row)
            checkVictory()
        }
    }
    
    func addMeadow(_ tile: SKTileGroup, _ column: Int, _ row: Int) {
        if tile.name  == "meadow" {
            let meadow = Meadow(column, row)
            meadows.append(meadow)
        }
        
    }
    
    func checkVictory() {
        if tiles.fogCount <= 0 {
            levelComplete()
        }
    }
    
    func checkStaleMate() {
        var column = 0
        var row = 0
        while column < 11 {
            if let tile = map.tileDefinition(atColumn: column, row: row) {
                if tile.name! == "fog" {
                checkUnreachableTile(column, row)
            }
            row += 1
            if row > 10 {
              column += 1
              row = 0
            }
        }
        }
    }
    
    func checkUnreachableTile(_ column: Int, _ row: Int) {
        //REFACTOR: could be combined with clearfog?
        let adjacentTiles = tiles.getTiles(column % 2)
        for tile in adjacentTiles {
            if let checkTile = map.tileDefinition(atColumn: column + tile[0], row: row + tile[1]) {
               if checkTile.name != "rock" || checkTile.name != nil {
                  return
               }
            }
            }
        infoPane.updateGameStatus("Stalemate detected")
        clearFog(column, row, false)
    }
    
}
