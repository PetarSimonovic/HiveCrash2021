//
//  StartGame.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 24/05/2021.
//3

import Foundation
import SpriteKit

extension GameScene {
    
    func startGame() {
        print("Starting game")
        gamePlaying = true
        tiles.prepareTiles(level, tileSet)
        map = tiles.startMap()
        self.addChild(map)
        self.map.zPosition = -1
        map.position = CGPoint(x: self.frame.maxX/2, y: self.frame.maxY/2)
        map.setScale(self.frame.width / 3200)
        if hive.bees.count == 0 {
            populateHive(1, true)
        }
        populateHive(4 + level, false)
        addButtons(map.frame.minY)
        createInfoPane()
        checkStaleMate()
 
    }
    
    func gameOver() {
        if hive.bees.count <= 0 || endGameConfirm == true {
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
        gamePlaying = false
      //  endTimer()
        let wait = SKAction.wait(forDuration: 3)
        let reset = SKAction.run({ self.resetGame() } )
        let gameOverSequence = SKAction.sequence([wait, reset])
        return gameOverSequence
    }
    
    
    @objc func resetGame() {
        endGameConfirm = false
        resetBees()
        print("Reset game")
        self.removeAllActions()
        self.removeAllChildren()
        flowers.removeAll()
        meadows.removeAll()
        enemyHive.bees.removeAll()
        hive = Hive()
        enemyHive = EnemyHive()
        tiles = Tiles()
        infoPane.reset()
        moveHive = false
        tiles.fogCount = 132
        startGame()
    }
    
    func startTimer() {
        let feederDelay = SKAction.wait(forDuration: 20)
        let feedBees = SKAction.run({ self.feedBees() })
        let feederSequence = SKAction.sequence([feederDelay, feedBees])
        self.run(SKAction.repeatForever(feederSequence))

    }
    func endTimer() {
        gameTimer?.invalidate()
        gameTimer = nil
        print("Timer, \(String(describing: gameTimer))")
    }
    
    
    
    

}
