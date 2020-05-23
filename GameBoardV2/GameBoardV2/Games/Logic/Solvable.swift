//
//  Solvable.swift
//  GameBoardV2
//
//  Created by Dylan Westfall on 5/23/20.
//  Copyright © 2020 practice. All rights reserved.
//

import Foundation

enum solveOptions {
    case solved
    case unsolved
}

protocol Solvable {
    func solved() -> Bool
    func playable() -> Bool
}
