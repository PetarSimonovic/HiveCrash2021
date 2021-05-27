//
//  DistanceCalculator.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 26/05/2021.
//

import Foundation
import SpriteKit


func flightSpeed(_ bee: Bee, _ destination: CGPoint) -> TimeInterval {
    let a = bee.sprite.position
    let b = destination
    let distance = sqrt((b.x - a.x)*(b.x - a.x) + (b.y - a.y)*(b.y - a.y))
    let beeSpeed = TimeInterval(distance / CGFloat(bee.speed))
    return beeSpeed
// calculate time using the rate * time = distance formula (solve for time)
// return a NSTimeInterval to signify time (in seconds as a return value)
}
