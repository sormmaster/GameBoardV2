//
//  BoardGame.swift
//  GameBoardV2
//
//  Created by Dylan Westfall on 5/23/20.
//  Copyright © 2020 practice. All rights reserved.
//

import Foundation
import UIKit

protocol BoardGameDelegate: class {
    func gameOver(end: Player?)
}

class BoardGame {
    private var playerTurn: Player = .playerOne
    private var board: [[String]] = []

    weak var gameDelegate: BoardGameDelegate?

    var gameOver: Bool = false
    var origins: [(Int,Int)] = []

    let moves: [(Int,Int)] = [(0,1), (1,0), (1,1), (0,-1), (-1,0), (-1,-1), (1,-1), (-1,1)]
    let numberOfPlayers: Int
    let inARow: Int
    let rows: Int
    let columns: Int

    init(playerCount: Int, rows: Int, columns: Int,  inARow: Int) {
        numberOfPlayers = playerCount
        self.inARow = inARow
        self.rows = rows
        self.columns = columns
        newGame()
    }

    func newGame() {
        var tempBoard: [[String]]  = []
        for _ in 1...columns {
            var row: [String] = []
            for _ in 1...rows {
                row.append(defaultValue())
            }
            tempBoard.append(row)
        }
        board = tempBoard
        playerTurn = .playerOne
        gameOver = false
        setOrigin()
    }

    private func setOrigin() {

        for value in 0 ... (rows - 1) {
            origins.append((0,value))
        }

        for value in 0 ... (columns - 1) {
            origins.append((value,(rows - 1)))
        }

        for value in (0 ... (columns - 2)).reversed() {
            origins.append(((columns - 1),value))
        }

        for value in (1 ... (rows - 2)).reversed() {
            origins.append((value,0))
        }
    }

    func getTurn() -> Player {
        return playerTurn
    }

    func defaultValue() -> String {
        return "-"
    }

    func makeMove(posx: Int, posy: Int) -> String {
        guard validMove(posx: posx, posy: posy) else{
            gameOver ? print("game is over go home") : print("placement was invalid")
            return defaultValue()
        }
        board[posy][posx] = playerTurn.giveValue()

        print(playerTurn.rawValue + " plays: " + String(posx) + " " + String(posy))

        if(playable()) {
            if(solved()){
                gameOver = true
                print(playerTurn.rawValue + " won")
                gameDelegate?.gameOver(end: playerTurn)
            }else {
                playerTurn = playerTurn.nextPlayer(count: numberOfPlayers)
                print("move was valid")

            }
        } else {
            print("no moves can be played")
            gameDelegate?.gameOver(end: nil)
        }

        return board[posy][posx]
    }
}

extension BoardGame: Solvable {
    func solved() -> Bool {
        var foundEnds: [solveOptions] = []
        origins.forEach { (x,y) in
            moves.forEach { (a,b) in
                foundEnds.append(solvingNode(solveCheck: [board[x][y]], x: x, y: y,movement: (a,b)))
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

    private func solvingNode(solveCheck: [String], x: Int, y: Int, movement: (Int,Int)) -> solveOptions{
        let move = nextMove(x: x, y: y, movement: movement)
        guard move != (0,0) else {
            if(solveCheck.count <= (inARow - 1)) {
                return .unsolved
            }
            return solve(group: solveCheck) ? .solved : .unsolved
        }
        var solveSend = solveCheck
        solveSend.append(board[move.0][move.1])
        return solvingNode(solveCheck: solveSend, x: move.0, y: move.1, movement: movement)
    }

    private func nextMove(x: Int, y: Int, movement: (Int,Int)) -> (Int,Int) {
        if(invalidOrValid(value: x, adjustment: movement.0, group: "row") && invalidOrValid(value: y, adjustment: movement.1, group: "column")) {
            return (x + movement.0,y + movement.1)
        } else {
            return (0,0)
        }
    }

    private func invalidOrValid(value: Int, adjustment: Int, group: String) -> Bool {
        let valid = group == "row" ? ((value + adjustment >= 0) && (value + adjustment < board.count)) : ((value + adjustment >= 0) && (value + adjustment < board[0].count))
        return valid
    }

    private func solve(group: [String]) -> Bool {
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

            if(itemsFound.count >= inARow) {
                hitFour = true
            }
        }

        return hitFour
    }

}


