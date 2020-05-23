//
//  TicTacToeGame.swift
//  GameBoardV2
//
//  Created by Dylan Westfall on 4/24/20.
//  Copyright © 2020 practice. All rights reserved.
//

import Foundation

class TicTacToeGame: BoardGame{
    init() {
        super.init(playerCount: 2, rows: 3, columns: 3, inARow: 3)
    }
}
