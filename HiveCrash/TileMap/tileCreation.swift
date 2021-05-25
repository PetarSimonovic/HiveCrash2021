//
//  TileSet.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 24/05/2021.
//

import Foundation
import SpriteKit



extension GameScene {
    
    func prepareTiles() {
        tileSet = loadTiles()
        hive = assignTiles("hive")
        meadow = assignTiles("meadow")
        lake = assignTiles("lake")
        rock = assignTiles("rock")
        fog = assignTiles("fog")
        map = startMap()
        self.addChild(map)
    }
    
    func loadTiles() -> SKTileSet {
        guard let tiles = SKTileSet(named: "TileSet") else {
                   // hint: don't use the filename for named, use the tileset inside
                   fatalError()
               }
        return tiles
    }
    
    
    func startMap() -> SKTileMapNode {

               let tileSize = tileSet.defaultTileSize // from image size
               let tileMap = SKTileMapNode(tileSet: tileSet, columns: 12, rows: 11, tileSize: tileSize)
                   tileMap.fill(with: fog) // fill or set by column/row
               //tileMap.setTileGroup(tileGroup, forColumn: 5, row: 5)
        tileMap.position = CGPoint(x: self.frame.maxX/2, y: self.frame.maxY/2)
        tileMap.setScale(self.frame.width / 3200)
        return tileMap
           }

    func assignTiles(_ tileName: String) -> SKTileGroup {
        return tileSet.tileGroups.first { $0.name == tileName }!
    }
    
    func placeHive(_ column: Int, _ row: Int ) {
        print("Hive placed at", column, row)
        hivePlaced = true
        hiveTile = [column, row]
        map.setTileGroup(hive, forColumn: hiveTile[0], row: hiveTile[1])

    }
    
    func readTile(_ column: Int, _ row: Int) {
        print(column, row)
    }
    
    func clearFog(_ centreTile: [Int]) {
        let column = centreTile[0]
        let row = centreTile[1]
        let tiles = getTiles(column % 2)
        for tile in tiles {
            map.setTileGroup(chooseTile(), forColumn: column + tile[0], row: row + tile[1]  )
        }
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
    
       let tile = Int.random(in: 0...6)
    
       switch tile {
        case 1:
            return rock
       case 2:
            return lake
        default:
            return meadow
        }
    }
}
    
    
