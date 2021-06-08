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
        print("Starting game")
        tiles.prepareTiles()
        map = tiles.startMap()
        self.addChild(map)
        map.position = CGPoint(x: self.frame.maxX/2, y: self.frame.maxY/2)
        map.setScale(self.frame.width / 3200)
        self.addChild(button)
        button.setScale(self.frame.width / 800)
        button.position = CGPoint(x: self.frame.maxX/2, y: self.frame.minY + 80 )
        createInfoPane()
 
    }
    
    func gameOver() {
        if bees.count <= 0 {
            infoPane.gameOver()
            let wait = SKAction.wait(forDuration: 10)
            let reset = SKAction.run({ self.resetGame() } )
            let gameOverSequence = SKAction.sequence([wait, reset])
            self.run(gameOverSequence)
        } else {
            return
        }

    }
    
    func levelComplete() {
        infoPane.levelComplete()
        let wait = SKAction.wait(forDuration: 20)
        let reset = SKAction.run({ self.resetGame() } )
        let gameOverSequence = SKAction.sequence([wait, reset])
        self.run(gameOverSequence)
        }
    
    @objc func resetGame() {
        gameTimer?.invalidate()
        print("Reset game")
        self.removeAllActions()
        self.removeAllChildren()
        flowers.removeAll()
        meadows.removeAll()
        bees.removeAll()
        hive = Hive()
        infoPane.reset()
        moveHive = false
        tiles.fogCount = 132
        startGame()
    }
    
    

}
