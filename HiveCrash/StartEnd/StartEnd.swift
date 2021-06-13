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
        tiles.prepareTiles(level, tileSet)
        map = tiles.startMap()
        self.addChild(map)
        self.map.zPosition = -1
        map.position = CGPoint(x: self.frame.maxX/2, y: self.frame.maxY/2)
        map.setScale(self.frame.width / 3200)
        addButtons()
        createInfoPane()
        checkStaleMate()
 
    }
    
    func gameOver() {
        if bees.count <= 0 {
            infoPane.gameOver()
            level = 1
            self.run(endGame())
        } else {
            return
        }
    }
    
    func levelComplete() {
        infoPane.levelComplete()
        level += 1
        self.run(endGame())
        }
    
    func endGame() -> SKAction {
        endTimer()
        let wait = SKAction.wait(forDuration: 20)
        let reset = SKAction.run({ self.resetGame() } )
        let gameOverSequence = SKAction.sequence([wait, reset])
        return gameOverSequence
    }
    
    
    @objc func resetGame() {
        resetBees()
        print("Reset game")
        self.removeAllActions()
        self.removeAllChildren()
        flowers.removeAll()
        meadows.removeAll()
        hive = Hive()
        tiles = Tiles()
        infoPane.reset()
        moveHive = false
        tiles.fogCount = 132
        startGame()
    }
    
    func startTimer() {
      gameTimer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(updateHive), userInfo: nil, repeats: true)
        print("Timer, \(String(describing: gameTimer))")
    }
    
    func endTimer() {
        gameTimer?.invalidate()
        gameTimer = nil
        print("Timer, \(String(describing: gameTimer))")
    }
    
    
    
    

}
