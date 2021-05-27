//
//  MapControllers.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 25/05/2021.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func clearFog(_ column: Int, _ row: Int, _ hive: Bool) {
        
        switch hive {
        case true:
            let adjacentTiles = tiles.getTiles(column % 2)
            for tile in adjacentTiles {
                let checkTile = map.tileDefinition(atColumn: column + tile[0], row: row + tile[1])
                    if let _ = checkTile?.userData?.value(forKey: "fog") {
                    let newTile = tiles.chooseTile()
                    map.setTileGroup(newTile, forColumn: column + tile[0], row: row + tile[1])
                    addFlower(newTile, column + tile[0], row + tile[1])
//                        if newTile == meadow {
//                            addFlower(column, row)
//                        }
            }
        }
        default:
            let newTile = tiles.chooseTile()
       //     print(newTile.SKTileGroup)
            map.setTileGroup(newTile, forColumn: column, row: row)
            addFlower(newTile, column, row)
//            if newTile == meadow {
//                addFlower(column, row)
//            }
        }
    }
    
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

    
}
