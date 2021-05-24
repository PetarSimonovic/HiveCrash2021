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
        map = startMap()
        hive = assignTiles("hive")
        meadow = assignTiles("meadow")
        lake = assignTiles("lake")
        rock = assignTiles("rock")
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
        let tileGroup = tileSet.tileGroups.first { $0.name == "fog" }
               tileMap.fill(with: tileGroup) // fill or set by column/row
               //tileMap.setTileGroup(tileGroup, forColumn: 5, row: 5)
        tileMap.setScale(self.frame.width / 3200)
        tileMap.position = CGPoint(x: self.frame.maxX/2, y: self.frame.maxY/2)
        return tileMap
           }

    func assignTiles(_ tileName: String) -> SKTileGroup {
        return tileSet.tileGroups.first { $0.name == tileName }!
    }
    
    }
    
    
