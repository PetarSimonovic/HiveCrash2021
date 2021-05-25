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
        let tiles = [
            [0, 1],
            [1, 0],
            [1, -1],
            [0, -1],
            [-1, -1],
            [-1, 0],
            ]
        let column = centreTile[0]
        let row = centreTile[1]
        for tile in tiles {
            map.setTileGroup(meadow, forColumn: column + tile[0], row: row + tile[1]  )
        }
    }
    
    }
    
    
