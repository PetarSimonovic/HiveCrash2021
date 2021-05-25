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
            print("X", location.x)
            print("Y", location.y)
            let column = map.tileColumnIndex(fromPosition: location)
            let row = map.tileRowIndex(fromPosition: location)
            print("Adjacent tiles are", column, row)
            let tile = map.tileDefinition(atColumn: column, row: row)
            if let _ = tile?.userData?.value(forKey: "fog") {
                if hive.isPlaced == false {
                    hive.place(column, row, location.x, location.y)
                    clearFog(hive.column, hive.row)
                    map.setTileGroup(tiles.hive, forColumn: hive.column, row: hive.row)
                }
                else {
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


         }

        }


    func clearFog(_ column: Int, _ row: Int) {
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
