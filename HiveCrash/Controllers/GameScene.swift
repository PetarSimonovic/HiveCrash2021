//
//  GameScene.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 24/05/2021.
//

import SpriteKit
import GameplayKit
import SwiftUI

class GameScene: SKScene {
    
   var tiles = Tiles()
   var map = SKTileMapNode()
   var hive = Hive()

  
    override func didMove(to view: SKView) {
     startGame()
    }
    

    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: map)
            let column = map.tileColumnIndex(fromPosition: location)
            let row = map.tileRowIndex(fromPosition: location)
            print("Adjacent tiles are", column, row)
            let tile = map.tileDefinition(atColumn: column, row: row)
            if let _ = tile?.userData?.value(forKey: "fog") {
                if hive.isPlaced == false {
                    hive.place(column, row)
                    clearFog(hive.location)
                    map.setTileGroup(tiles.hive, forColumn: hive.location[0], row: hive.location[1])
                }
                else {
                    map.setTileGroup(tiles.chooseTile(), forColumn: column, row: row)
                    clearFog([column, row])
                }
            }


         }

        }


    func clearFog(_ centreTile: [Int]) {
        let column = centreTile[0]
        let row = centreTile[1]
        let adjacentTiles = tiles.getTiles(column % 2)
        for tile in adjacentTiles {
            let checkTile = map.tileDefinition(atColumn: column + tile[0], row: row + tile[1])
            if let _ = checkTile?.userData?.value(forKey: "fog") {
            map.setTileGroup(tiles.chooseTile(), forColumn: column + tile[0], row: row + tile[1]  )
            }
        }
    }
  
    
   
    
//
//    override func update(_ currentTime: TimeInterval) {
//        // Called before each frame is rendered
//
//        // Initialize _lastUpdateTime if it has not already been
//
//}
}
