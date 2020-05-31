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
        super.init(playerCount: 2, rows: 7, columns: 6, inARow: 4)

    }

    override func makeMove(posx: Int, posy: Int) -> String {
        let move = returncolumn(posx: posx, posy: posy)
        guard validMove(posx: posx, posy: posy) else {
                  gameOver ? print("game is over go home") : print("placement was invalid")
                  return defaultValue()
              }
        board[move.1][move.0] = playerTurn.giveValue()

        print(playerTurn.rawValue + " plays: " + String(move.0) + " " + String(move.1))

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

        return board[move.1][move.0]
    }

    func returncolumn(posx: Int, posy: Int) ->  (Int,Int){

        var column: [String]  = []

        for list in board {
            column.append(list[posx])
        }

        guard let index = column.lastIndex(of: defaultValue()) else {
            return (board[0].count + 1,board.count + 1)
        }
        return (x: posx,y: Int(index))
    }

    override func validMove(posx: Int, posy: Int) -> Bool {
        if(!gameOver){
            let move = returncolumn(posx: posx, posy: posy)
            guard move.1 < board.count && move.0 < board[0].count && board[move.1][move.0] == "-" else { return false}
                   return true
        } else { return false }
    }
}
