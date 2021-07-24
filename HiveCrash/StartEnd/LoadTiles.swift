//
//  LoadSave.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 10/06/2021.
//

import Foundation
import SpriteKit

//extension GameScene {

func loadTiles() -> SKTileSet {
    guard let tiles = SKTileSet(named: "TileSet") else {
               // hint: don't use the filename for named, use the tileset inside
               fatalError()
           }
    return tiles
 }





//}
