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
        let scaler = UIScreen.main.bounds.height * 0.01
        addBeeInfo()
        positionBeeInfo(scaler)

       // addChild(infoPane.tileName)
        addChild(infoPane.hivePollen)
        addChild(infoPane.pollenStatus)
        addChild(infoPane.beePopulation)
        addChild(infoPane.gameStatus_1)
        addChild(infoPane.gameStatus_2)
        addChild(infoPane.gameStatus_3)
        addChild(infoPane.beeStatus)
        infoPane.updateDisplay()
        infoPane.hivePollen.position = CGPoint(x: frame.minX + scaler , y: frame.maxY - scaler)
        infoPane.beePopulation.position = CGPoint(x: frame.minX + scaler , y: frame.maxY - (scaler * 4))
        infoPane.tileName.position = CGPoint(x: frame.minX + scaler, y: frame.maxY - (scaler * 7))
        infoPane.pollenStatus.position = CGPoint(x: frame.minX + scaler , y: frame.maxY - (scaler * 7))
        infoPane.gameStatus_1.position = CGPoint(x: frame.minX + scaler , y: frame.minY + (scaler * 10))
        infoPane.gameStatus_2.position = CGPoint(x: frame.minX + scaler , y: frame.minY + (scaler * 7))
        infoPane.gameStatus_3.position = CGPoint(x: frame.minX + scaler , y: frame.minY + (scaler * 4))
    }
    
    func addBeeInfo() {
        addChild(infoPane.beeName)
        addChild(infoPane.beeType)
        addChild(infoPane.beePollen)
        addChild(infoPane.beeHealth)
        addChild(infoPane.beeRange)
    }
    
    func positionBeeInfo(_ scaler: CGFloat) {
        infoPane.beeName.position = CGPoint(x: frame.midX + scaler , y: frame.maxY - scaler)
        infoPane.beeType.position = CGPoint(x: frame.midX + scaler , y: frame.maxY - scaler * 4)
        infoPane.beeHealth.position = CGPoint(x: frame.midX + scaler , y: frame.maxY - scaler * 7)
        infoPane.beePollen.position = CGPoint(x: frame.midX + scaler , y: frame.maxY - scaler * 10)
      //  infoPane.beeRange.position = CGPoint(x: frame.midX + scaler , y: frame.maxY - scaler * 13)
    }
    
    func updateInfoPane(_ tile: SKTileDefinition, _ column: Int, _ row: Int) {
        if tutorial.on {return}
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

