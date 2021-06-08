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
        addChild(infoPane.tileName)
        addChild(infoPane.hivePollen)
        addChild(infoPane.pollenStatus)
        addChild(infoPane.beeName)
        addChild(infoPane.beePollen)
        addChild(infoPane.beePopulation)
        addChild(infoPane.gameStatus_1)
        addChild(infoPane.gameStatus_2)
        addChild(infoPane.gameStatus_3)
        addChild(infoPane.beeStatus)
        infoPane.hivePollen.position = CGPoint(x: frame.minX + 10 , y: frame.maxY - 10)
        infoPane.beePopulation.position = CGPoint(x: frame.minX + 10 , y: frame.maxY - 30)
        infoPane.tileName.position = CGPoint(x: frame.minX + 10, y: frame.maxY - 50)
        infoPane.pollenStatus.position = CGPoint(x: frame.minX + 10 , y: frame.maxY - 70)
        infoPane.beeName.position = CGPoint(x: frame.maxX - 100 , y: frame.maxY - 10)
        infoPane.beePollen.position = CGPoint(x: frame.maxX - 100 , y: frame.maxY - 30)
        infoPane.gameStatus_1.position = CGPoint(x: frame.minX + 10 , y: frame.minY + 65)
        infoPane.gameStatus_2.position = CGPoint(x: frame.minX + 10 , y: frame.minY + 50)
        infoPane.gameStatus_3.position = CGPoint(x: frame.minX + 10 , y: frame.minY + 35)
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
    
}

