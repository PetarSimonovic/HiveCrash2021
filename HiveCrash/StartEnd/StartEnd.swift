//
//  StartGame.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 24/05/2021.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func startGame() {
        print("Startibg game)")
        tiles.prepareTiles()
        map = tiles.startMap()
        self.addChild(map)
        map.position = CGPoint(x: self.frame.maxX/2, y: self.frame.maxY/2)
        map.setScale(self.frame.width / 3200)
        createInfoPane()
        5.times {
            addBee()
        }
       
 
    }
    
    func gameOver() {
        if bees.count <= 0 {
            infoPane.gameOver()
            self.run(SKAction.wait(forDuration: 10))
            resetGame()
        }

    }
    
    @objc func resetGame() {
        print("Reset game")
        self.removeAllActions()
        self.removeAllChildren()
        flowers.removeAll()
        meadows.removeAll()
        bees.removeAll()
        hive = Hive()
        infoPane.reset()
        moveHive = false
        startGame()
    }
    
    

}
