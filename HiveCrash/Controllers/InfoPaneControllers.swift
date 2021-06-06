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
        addChild(infoPane.pollenCount)
        infoPane.tileName.position = CGPoint(x: frame.minX + 10, y: frame.maxY - 10)
        infoPane.pollenCount.position = CGPoint(x: frame.minX + 10 , y: frame.maxY - 30)
    }
    
    func updateInfoPane(_ tile: SKTileDefinition, _ column: Int, _ row: Int) {
        switch tile.name {
        case "fog":
            infoPane.updateTileName("Fog")
        case "meadow":
            infoPane.updateTileName("Meadow")
        case "flowerMeadow":
            infoPane.updateTileName("Flower Meadow")
            let flower = flowers.first(where: {$0.column == column && $0.row == row})!
            infoPane.updateFlowerInfo(column, row, flower)
        case "rock":
            infoPane.updateTileName("Rock")
        case "lake":
            infoPane.updateTileName("Lake")
        case "hive":
            infoPane.updateTileName("Hive")
        default:
            return
        }
    }
    
}

