//
//  TicTacToeGame.swift
//  GameBoardV2
//
//  Created by Dylan Westfall on 4/24/20.
//  Copyright © 2020 practice. All rights reserved.
//

import Foundation

class TicTacToeGame{
    private var playerOneTurn: Bool = true
    private var board: [[String]] = [["","",""],["","",""],["","",""]]
    init() {
        newGame()
    }

    func makeMove(posx: Int, posy: Int) {
        guard posx < 3 && posy < 3 && board[posx][posy] == "" else {return}
        board[posx][posy] = playerOneTurn ? "X" : "O"
        print(board)
        playerOneTurn = !playerOneTurn
    }

    func getBoard() -> [[String]] {
        return board
    }

    func newGame() {
        board = [["","",""],["","",""],["","",""]]
        playerOneTurn = true
    }

    func getTurn() -> Bool {
        return playerOneTurn
    }
}
