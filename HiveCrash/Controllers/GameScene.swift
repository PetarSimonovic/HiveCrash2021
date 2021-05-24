//
//  GameScene.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 24/05/2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
   var tileSet = SKTileSet ()
   var map = SKTileMapNode()
   var hive = SKTileGroup()
   var meadow = SKTileGroup()
   var lake = SKTileGroup()
  var rock = SKTileGroup()
    
    override func didMove(to view: SKView) {
     startGame()
    }
    
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//        }

 
  
    
   
    
//
//    override func update(_ currentTime: TimeInterval) {
//        // Called before each frame is rendered
//
//        // Initialize _lastUpdateTime if it has not already been
//
//}
}
