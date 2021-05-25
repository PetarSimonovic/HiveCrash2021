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
            let tile = map.tileDefinition(atColumn: column, row: row)
            if let _ = tile?.userData?.value(forKey: "fog") {
                if hive.isPlaced == false {
                    placeHive(location, column, row)
                }
                else {
                    addBee(location, column, row)
                }
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
