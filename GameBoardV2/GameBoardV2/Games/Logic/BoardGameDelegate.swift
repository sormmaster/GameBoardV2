//
//  BoardGameDelegate.swift
//  GameBoardV2
//
//  Created by Dylan Westfall on 5/21/20.
//  Copyright © 2020 practice. All rights reserved.
//

import Foundation

enum ending {
    case playerOne
    case playerTwo
    case noContest
}

protocol BoardGameDelegate: class {
    func gameOver(end: ending)
}
