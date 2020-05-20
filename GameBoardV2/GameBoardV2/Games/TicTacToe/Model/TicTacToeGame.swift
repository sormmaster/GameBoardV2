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
    private var board: [[String]] = []
    let origins = [(0,0), (0,1), (0,2), (1,2), (2,2), (2,1), (2,0), (1,0)]
    let moves = [(0,1), (1,0), (1,1), (0,-1), (-1,0), (-1,-1), (1,-1), (-1,1)]

    enum solveOptions {
        case solved
        case unsolved
        case finished
    }

    init() {
        newGame()
    }

    func validMove(posx: Int, posy:Int) -> Bool {
        return posx < 3 && posy < 3 && board[posy][posx] == "-"
    }

    func makeMove(posx: Int, posy: Int) -> String {
        board[posy][posx] = playerOneTurn ? "X" : "O"
        if(playable() && !solved()) {
            playerOneTurn = !playerOneTurn
        }
        return board[posy][posx]
    }

    func newGame() {
        var tempBoard: [[String]]  = []
        for _ in 1...3 {
            var row: [String] = []
            for _ in 1...3 {
                row.append(defaultValue())
            }
            tempBoard.append(row)
        }
        board = tempBoard
        playerOneTurn = true
    }

    func getTurn() -> Bool {
        return playerOneTurn
    }

    func defaultValue() -> String {
        return "-"
    }

    func solved() -> Bool {
        return recursiveSolve()
    }

    func playable() -> Bool {
        var playable: Bool = false

        board.forEach({ row in
            if(row.contains("-") && !playable){
                playable = true
            }
        })
        return playable
    }

    func recursiveSolve() -> Bool {
        var foundEnds: [solveOptions] = []
        origins.forEach { (x,y) in
            moves.forEach { (a,b) in
                foundEnds.append(solvingNode(solve: [board[x][y]], x: x, y: y,movement: (a,b)))
            }
        }
        return foundEnds.contains(.solved)
    }

    func solvingNode(solve: [String], x: Int, y: Int, movement: (Int,Int)) -> solveOptions{
        if(solve.count >= 3 && !solve.contains("-")) {
            if(solve[0] == solve[1] && solve[1] == solve[2]) {
                return .solved
            } else {
                return .finished
            }
        }
        let move = nextMove(x: x, y: y, movement: movement)
        guard move != (0,0) else {
            return .unsolved
        }
        var solveSend = solve
        solveSend.append(board[move.0][move.1])
        return solvingNode(solve: solveSend, x: move.0, y: move.1, movement: movement)
    }

    func nextMove(x: Int, y: Int, movement: (Int,Int)) -> (Int,Int) {
        if(invalidOrValid(value: x, adjustment: movement.0) && invalidOrValid(value: y, adjustment: movement.1)) {
            return (x + movement.0,y + movement.1)
        } else {
            return (0,0)
        }
    }

    func invalidOrValid(value: Int, adjustment: Int) -> Bool {
        return (value + adjustment >= 0) && (value + adjustment < board.count)
    }

}
