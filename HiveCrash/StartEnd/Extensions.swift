//
//  Times.swift
//  HiveCrash
//
//  Created by Petar Simonovic on 07/06/2021.
//

import Foundation

extension Int {
    func times(_ f: () -> ()) {
        if self > 0 {
            for _ in 0..<self {
                f()
            }
        }
    }
    
    func times(_ f: @autoclosure () -> ()) {
        if self > 0 {
            for _ in 0..<self {
                f()
            }
        }
    }
}

extension Array {

    mutating func rotateBees() {
        append(removeFirst())
    }
}

