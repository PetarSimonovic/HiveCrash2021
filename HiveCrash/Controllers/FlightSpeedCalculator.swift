//
//  DistanceCalculator.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 26/05/2021.
//

import Foundation
import SpriteKit


func flightSpeed(_ a: CGPoint, _ b: CGPoint, _ speed: Int) -> TimeInterval {
    let distance = sqrt((b.x - a.x)*(b.x - a.x) + (b.y - a.y)*(b.y - a.y))
    let beeSpeed = TimeInterval(distance / CGFloat(speed))
    return beeSpeed
// calculate time using the rate * time = distance formula (solve for time)
// return a NSTimeInterval to signify time (in seconds as a return value)
}
