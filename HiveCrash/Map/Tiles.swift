//
//  TileSet.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 24/05/2021.
//

import Foundation
import SpriteKit



class Tiles {
    
    var tileSet = SKTileSet ()
    var hive = SKTileGroup()
    var meadow = SKTileGroup()
    var lake = SKTileGroup()
    var rock = SKTileGroup()
    var fog = SKTileGroup()
    var enemyHive = SKTileGroup()
    var flowerMeadow = SKTileGroup()
    var hiveTile: [Int] = []
    var hivePlaced: Bool = false
    var fogCount: Int = 132
    var flowerMeadows: Int = 8
    var difficulty: Int = 8
    
    func startMap() -> SKTileMapNode {
          let tileSize = tileSet.defaultTileSize // from image size
          let tileMap = SKTileMapNode(tileSet: tileSet, columns: 12, rows: 12, tileSize: tileSize)
              tileMap.fill(with: fog) // fill or set by column/row
               //tileMap.setTileGroup(tileGroup, forColumn: 5, row: 5)
       
        return tileMap
           }
    
    func prepareTiles(_ level: Int, _ tiles: SKTileSet) {
        self.flowerMeadows -= level
        self.difficulty -= level
        if self.difficulty < 3 {
            self.difficulty = 3
        }
        tileSet = tiles
        hive = assignTiles("hive")
        meadow = assignTiles("meadow")
        flowerMeadow = assignTiles("flowerMeadow")
        lake = assignTiles("lake")
        rock = assignTiles("rock")
        fog = assignTiles("fog")
        enemyHive = assignTiles("enemyHive")
      
    }

    private func assignTiles(_ tileName: String) -> SKTileGroup {
        return tileSet.tileGroups.first { $0.name == tileName }!
    }
    
    
    func readTile(_ column: Int, _ row: Int) {
        print(column, row)
    }
    
    
    func getTiles(_ even: Int) -> [[Int]] {
        switch even {
        case 0 :
        return [
         [0, 1],
         [1, 0],
         [1, -1],
         [0, -1],
         [-1, -1],
         [-1, 0],
          ]
        default:
         return [
             [0, 1],
             [1, 1],
             [1, 0],
             [-1, 0],
             [0, -1],
             [-1, 0],
             [-1, 1],
              ]
        }
    }
    
    func chooseTile(_ level: Int) -> SKTileGroup {
        
        self.fogCount -= 1
        print("Remaining tiles: \(self.fogCount)")
    
        let tile = Int.random(in: 0...self.difficulty)
    
       switch tile {
        case 1:
            return rock
       case 2:
            return lake
       case 3:
        print("Meadow/flower", self.flowerMeadows)
        if self.flowerMeadows >= 3 {
           self.flowerMeadows -= 1
           return flowerMeadow
        } else {
          return meadow
        }
        default:
            return meadow
        }
    }
}
    
    
