//
//  FlowerController.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 26/05/2021.
//

import Foundation
import SpriteKit

extension GameScene {
    
func addFlower(_ tile: SKTileGroup, _ column: Int, _ row: Int) {
    if tile.name! == "flowerMeadow" {
    
        let location = map.centerOfTile(atColumn: column, row: row)
        let flower = Flower(location, column, row)
 //   let beeSprite = bee.createBee()
        map.addChild(flower.sprite)
        flowers.append(flower)
        flower.sprite.position = location
    }

}
    func checkPollen(_ bee: Bee, _ flower: Flower) {
        
        switch flower.inBloom {
        case true:
            bee.collectPollen(flower)
        default:
            return
        }
    }
}
