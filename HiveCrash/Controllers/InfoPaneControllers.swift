//
//  infoPaneController.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 05/06/2021.
//

import Foundation
import SpriteKit

extension GameScene {

    func createInfoPane() {
        
        addHiveInfo()
        addBeeInfo()
        addGameInfo()
        positionBeeInfo()
        positionHiveInfo()
        positionGameInfo()
        

    }
    
//    func infoPane.updateGameStatus(_ text: String) {
//        let scrollNode = infoPane.updateGameStatus(text)
//        self.addChild((scrollNode))
//        scrollNode.position = CGPoint(x: self.frame.maxX + (previousScrollNode.position.x + 20), y: self.frame.minY + 100)
//        scrollNodes.insert(scrollNode, at: 0)
//        previousScrollNode = scrollNode
//    }
    

    
    func addHiveInfo() {
        addChild(infoPane.tileName)
        addChild(infoPane.hivePollen)
        addChild(infoPane.pollenStatus)
        addChild(infoPane.beePopulation)
    }
    
    func positionHiveInfo() {
        infoPane.hivePollen.position = CGPoint(x: frame.minX + 10 , y: frame.maxY - 10)
        infoPane.beePopulation.position = CGPoint(x: frame.minX + 10 , y: frame.maxY - 30)
        infoPane.tileName.position = CGPoint(x: frame.minX + 10, y: frame.maxY - 50)
        infoPane.pollenStatus.position = CGPoint(x: frame.minX + 10 , y: frame.maxY - 70)
    }
    
    func addBeeInfo() {
        addChild(infoPane.beeName)
        addChild(infoPane.beeType)
        addChild(infoPane.beePollen)
        addChild(infoPane.beeHealth)
        addChild(infoPane.beeRange)
    }
    
    func positionBeeInfo() {
        infoPane.beeName.position = CGPoint(x: (frame.midX + frame.midX / 3) , y: frame.maxY - 10)
        infoPane.beeType.position = CGPoint(x: (frame.midX + frame.midX / 3), y: frame.maxY - 25)
        infoPane.beeHealth.position = CGPoint(x: (frame.midX + frame.midX / 3), y: frame.maxY - 40)
        infoPane.beePollen.position = CGPoint(x: (frame.midX + frame.midX / 3) , y: frame.maxY - 55)
        infoPane.beeRange.position = CGPoint(x: (frame.midX + frame.midX / 3) , y: frame.maxY - 70)
    }
    
    func addGameInfo() {
        self.addChild(infoPane.gameStatus_1)
        self.addChild(infoPane.gameStatus_2)
        self.addChild(infoPane.gameStatus_3)
    }
    
    
    func positionGameInfo() {
        infoPane.gameStatus_1.position = CGPoint(x: (frame.minX + 10) , y: frame.minY + 50)
        infoPane.gameStatus_2.position = CGPoint(x: (frame.minX + 10), y: frame.minY + 45)
        infoPane.gameStatus_3.position = CGPoint(x: (frame.minX + 10), y: frame.minY + 20)
      
    }
    
    func updateInfoPane(_ tile: SKTileDefinition, _ column: Int, _ row: Int) {
        switch tile.name {
        case "fog":
            infoPane.updateTileName("Fog")
        case "meadow":
            if let meadow = meadows.first(where: {$0.column == column && $0.row == row}) {
              infoPane.updateTileName("Meadow")
              infoPane.updateMeadowInfo(meadow)
            }
        case "flowerMeadow":
            infoPane.updateTileName("Flower Meadow")
            let flower = flowers.first(where: {$0.column == column && $0.row == row})!
            infoPane.updateFlowerInfo(column, row, flower)
        case "rock":
            infoPane.updateTileName("Rock")
        case "lake":
            infoPane.updateTileName("Lake")
        default:
            return
        }
    }
    
    func scrollText() {
    
    enumerateChildNodes(withName: "gameInfo", using: ({
        (node, error) in
        let textNode = node as! SKLabelNode
        textNode.position = CGPoint(x: textNode.position.x - 1, y: textNode.position.y)
        if textNode.position.x <= self.frame.minX - textNode.frame.width {
            textNode.removeFromParent()
       
        }
    }))
        
    }
    
}

