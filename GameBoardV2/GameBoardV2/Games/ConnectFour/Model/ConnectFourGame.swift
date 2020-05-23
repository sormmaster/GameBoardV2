//
//  ConnectFourGame.swift
//  GameBoardV2
//
//  Created by Dylan Westfall on 5/19/20.
//  Copyright © 2020 practice. All rights reserved.
//

import Foundation

class ConnectFourGame: BoardGame {
    init() {
        super.init(playerCount: 2, rows: 6, columns: 7, inARow: 4)
        playGame()
    }

    func playGame() {
        makeMove(posx: 0, posy: 0)
        makeMove(posx: 4, posy: 4)
        makeMove(posx: 0, posy: 1)
        makeMove(posx: 5, posy: 5)
        makeMove(posx: 0, posy: 2)
        makeMove(posx: 4, posy: 5)
        makeMove(posx: 0, posy: 3)
    }

}
