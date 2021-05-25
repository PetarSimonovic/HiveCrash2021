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
    
   var tileSet = SKTileSet ()
   var map = SKTileMapNode()
   var hive = SKTileGroup()
   var meadow = SKTileGroup()
   var lake = SKTileGroup()
   var rock = SKTileGroup()
   var fog = SKTileGroup()
   var hiveTile: [Int] = []
   var hivePlaced: Bool = false
  
    override func didMove(to view: SKView) {
     startGame()
    }
    

    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: map)
            let column = map.tileColumnIndex(fromPosition: location)
            let row = map.tileRowIndex(fromPosition: location)
            let tile = map.tileDefinition(atColumn: column, row: row)
            if let _ = tile?.userData?.value(forKey: "fog") {
               hivePlaced == false ? placeHive(column, row) : readTile(column, row)
               clearFog(hiveTile)
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
