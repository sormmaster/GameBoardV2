//
//  ConnectFourGame.swift
//  GameBoardV2
//
//  Created by Dylan Westfall on 5/19/20.
//  Copyright © 2020 practice. All rights reserved.
//

import Foundation

class ConnectFourGame {
    private var playerOneTurn: Bool = true
    private var board: [[String]] = []

    weak var gameDelegate: BoardGameDelegate?

    var gameOver: Bool = false
    var origins: [(Int,Int)] = []

    let moves: [(Int,Int)] = [(0,1), (1,0), (1,1), (0,-1), (-1,0), (-1,-1), (1,-1), (-1,1)]

    enum solveOptions {
        case solved
        case unsolved
        case finished
    }

    init() {
        newGame()
        setOrigin()
    }

    func newGame() {
        var tempBoard: [[String]]  = []
        for _ in 1...7 {
            var row: [String] = []
            for _ in 1...6 {
                row.append(defaultValue())
            }
            tempBoard.append(row)
        }
        board = tempBoard
        playerOneTurn = true
        gameOver = false
    }

    private func setOrigin() {

        for value in 0 ... 5 {
            origins.append((0,value))
        }

        for value in 0 ... 6 {
            origins.append((value,5))
        }

        for value in (0 ... 4).reversed() {
            origins.append((6,value))
        }

        for value in (1 ... 5).reversed() {
            origins.append((value,0))
        }
    }

    func getTurn() -> Bool {
        return playerOneTurn
    }

    func defaultValue() -> String {
        return "-"
    }

    func makeMove(posx: Int, posy: Int) -> String {
        guard validMove(posx: posx, posy: posy) else{
            gameOver ? print("game is over go home") : print("placement was invalid")
            return defaultValue()
        }
        board[posy][posx] = playerOneTurn ? "X" : "O"

        playerOneTurn ? print("player one plays: " + String(posx) + " " + String(posy)) : print("player two plays: " + String(posx) + " " + String(posy))

        if(playable()) {
            if(solved()){
                gameOver = true
                playerOneTurn ? print("player one won") : print("player two won")
                playerOneTurn ? gameDelegate?.gameOver(end: .playerOne) : gameDelegate?.gameOver(end: .playerTwo)
            }else {
                print("move was valid")
                playerOneTurn = !playerOneTurn
            }
        } else {
            print("no moves can be played")
            gameDelegate?.gameOver(end: .noContest)
        }

        return board[posy][posx]
    }
    
    func solved() -> Bool {
         var foundEnds: [solveOptions] = []
               origins.forEach { (x,y) in
                   moves.forEach { (a,b) in
                       foundEnds.append(solvingNode(solve: [board[x][y]], x: x, y: y,movement: (a,b)))
                   }
               }
               return foundEnds.contains(.solved)
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

    func validMove(posx: Int, posy:Int) -> Bool {
        if(!gameOver){
            return posx < board.count && posy < board[0].count && board[posy][posx] == "-"
        } else { return false }
    }



    func solvingNode(solve: [String], x: Int, y: Int, movement: (Int,Int)) -> solveOptions{
        let move = nextMove(x: x, y: y, movement: movement)
        guard move != (0,0) else {
            if(solve.count <= 3) {
                return .unsolved
            }
            return fourInARow(group: solve) ? .solved : .unsolved
        }
        var solveSend = solve
        solveSend.append(board[move.0][move.1])
        return solvingNode(solve: solveSend, x: move.0, y: move.1, movement: movement)
    }

    func nextMove(x: Int, y: Int, movement: (Int,Int)) -> (Int,Int) {
        if(invalidOrValid(value: x, adjustment: movement.0, group: "row") && invalidOrValid(value: y, adjustment: movement.1, group: "column")) {
            return (x + movement.0,y + movement.1)
        } else {
            return (0,0)
        }
    }

    func invalidOrValid(value: Int, adjustment: Int, group: String) -> Bool {
        let valid = group == "row" ? ((value + adjustment >= 0) && (value + adjustment < board.count)) : ((value + adjustment >= 0) && (value + adjustment < board[0].count))
        return valid
    }

    func fourInARow(group: [String]) -> Bool {
        var itemsFound: [String] = []
        var currentCheck = defaultValue()
        var hitFour = false
        for item in group {
            if(item != currentCheck) {
                itemsFound = []
                currentCheck = item
            }

            if(item != defaultValue()) {
                itemsFound.append(item)
            }

            if(itemsFound.count >= 4) {
                hitFour = true
            }
        }

        return hitFour
    }
}
