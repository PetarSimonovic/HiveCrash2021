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
       // self.isPaused = false
        tutorial.reset()
        createMap()
        print("Starting game")
        gamePlaying = true
        if intro {
            startDemo()
        } else
        { if hive.bees.count == 0 { populateHive(1, true) }
        populateHive(4 + level, false)
        addButtons(map.frame.minY)
        createInfoPane()
        checkStaleMate()
        }
 
    }
    
    func gameOver() {
        if hive.bees.count <= 0 || endGameConfirm == true || intro == true {
            gamePlaying = false
            infoPane.gameOver()
            level = 1
            enemies = false
            hive = Hive()
            self.run(endGame())
        } else {
            return
        }
    }
    
    func levelComplete() {
        infoPane.levelComplete()
        level += 1
        enemies = true
        self.run(endGame())
        updateSavedBeeLevels()
        }
    
    func endGame() -> SKAction {
      //  endTimer()
      //  self.isPaused = true
        let wait = SKAction.wait(forDuration: 1)
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
        enemyHive = EnemyHive()
        tiles = Tiles()
        infoPane.reset()
        moveHive = false
        tiles.fogCount = tiles.mapRows * tiles.mapColumns
        if level == 1 {
            toggleIntro()
        }
        print("Intro", intro)
        startGame()
    }
    
    func startTimer() {
        let feederDelay = SKAction.wait(forDuration: 20)
        let feedBees = SKAction.run({ self.feedBees() })
        let updateIntroBees = SKAction.run({ self.beeFlight() })
        let feederSequence = SKAction.sequence([feederDelay, feedBees, updateIntroBees])
        self.run(SKAction.repeatForever(feederSequence))

    }
    func endTimer() {
        gameTimer?.invalidate()
        gameTimer = nil
        print("Timer, \(String(describing: gameTimer))")
    }
    
    
    
    

}
