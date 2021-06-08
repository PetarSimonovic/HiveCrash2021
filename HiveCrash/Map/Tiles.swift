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
    var flowerMeadow = SKTileGroup()
    var hiveTile: [Int] = []
    var hivePlaced: Bool = false
    var fogCount: Int = 132
    
    
    func startMap() -> SKTileMapNode {

          let tileSize = tileSet.defaultTileSize // from image size
          let tileMap = SKTileMapNode(tileSet: tileSet, columns: 12, rows: 11, tileSize: tileSize)
              tileMap.fill(with: fog) // fill or set by column/row
               //tileMap.setTileGroup(tileGroup, forColumn: 5, row: 5)
       
        return tileMap
           }
    
    func prepareTiles() {
        tileSet = loadTiles()
        hive = assignTiles("hive")
        meadow = assignTiles("meadow")
        flowerMeadow = assignTiles("flowerMeadow")
        lake = assignTiles("lake")
        rock = assignTiles("rock")
        fog = assignTiles("fog")
      
    }
    
    private func loadTiles() -> SKTileSet {
        guard let tiles = SKTileSet(named: "TileSet") else {
                   // hint: don't use the filename for named, use the tileset inside
                   fatalError()
               }
        return tiles
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
    
    func chooseTile() -> SKTileGroup {
        
        self.fogCount -= 1
        print("Remaining tiles: \(self.fogCount)")
    
       let tile = Int.random(in: 0...6)
    
       switch tile {
        case 1:
            return rock
       case 2:
            return lake
       case 3:
            return flowerMeadow
        default:
            return meadow
        }
    }
}
    
    
