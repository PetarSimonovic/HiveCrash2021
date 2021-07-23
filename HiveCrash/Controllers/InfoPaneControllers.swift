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
        
        addBeeInfo()
        positionBeeInfo()

        addChild(infoPane.tileName)
        addChild(infoPane.hivePollen)
        addChild(infoPane.pollenStatus)
        addChild(infoPane.beePopulation)
        addChild(infoPane.gameStatus_1)
        addChild(infoPane.gameStatus_2)
        addChild(infoPane.gameStatus_3)
        addChild(infoPane.beeStatus)
        infoPane.updateDisplay()
        infoPane.hivePollen.position = CGPoint(x: frame.minX + 10 , y: frame.maxY - 10)
        infoPane.beePopulation.position = CGPoint(x: frame.minX + 10 , y: frame.maxY - 30)
        infoPane.tileName.position = CGPoint(x: frame.minX + 10, y: frame.maxY - 50)
        infoPane.pollenStatus.position = CGPoint(x: frame.minX + 10 , y: frame.maxY - 70)
                infoPane.gameStatus_1.position = CGPoint(x: frame.minX + 10 , y: frame.minY + 65)
        infoPane.gameStatus_2.position = CGPoint(x: frame.minX + 10 , y: frame.minY + 50)
        infoPane.gameStatus_3.position = CGPoint(x: frame.minX + 10 , y: frame.minY + 35)
    }
    
    func addBeeInfo() {
        addChild(infoPane.beeName)
        addChild(infoPane.beeType)
        addChild(infoPane.beePollen)
        addChild(infoPane.beeHealth)
        addChild(infoPane.beeRange)
    }
    
    func positionBeeInfo() {
        infoPane.beeName.position = CGPoint(x: frame.midX + 10 , y: frame.maxY - 10)
        infoPane.beeType.position = CGPoint(x: frame.midX + 10 , y: frame.maxY - 25)
        infoPane.beeHealth.position = CGPoint(x: frame.midX + 10 , y: frame.maxY - 40)
        infoPane.beePollen.position = CGPoint(x: frame.midX + 10 , y: frame.maxY - 55)
        infoPane.beeRange.position = CGPoint(x: frame.midX + 10 , y: frame.maxY - 70)
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
    
    func updateBeeInfoPanes() {
        for bee in hive.bees {
            bee.infoPane.position = bee.sprite.position
        }
    }
    
}

