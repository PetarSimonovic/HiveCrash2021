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
  
    override func didMove(to view: SKView) {
     startGame()
    }
    

    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: map)
            print(location)
            let column = map.tileColumnIndex(fromPosition: location)
            let row = map.tileRowIndex(fromPosition: location)
            print(column)
            print(row)

            let tile = map.tileDefinition(atColumn: column, row: row)
            if let _ = tile?.userData?.value(forKey: "fog") {
                print("Here")
                map.setTileGroup(hive, forColumn: column, row: row)
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
