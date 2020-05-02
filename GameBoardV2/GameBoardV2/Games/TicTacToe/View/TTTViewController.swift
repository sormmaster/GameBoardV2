//
//  TTTViewController.swift
//  GameBoardV2
//
//  Created by Dylan Westfall on 4/25/20.
//  Copyright © 2020 practice. All rights reserved.
//

import UIKit

class TTTViewController: UIViewController {

    @IBOutlet weak var TTTTitle: UILabel!
    @IBOutlet weak var BoardView: UIView!

    weak var coordinator: TTTCoordinator?

    var game: TicTacToeGame?
    var boardViews: [[BoardPieceView]] = [[],[],[]]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBoard()
    }

    func setupBoard() {
        guard let game = game else {return}
        let board = game.getBoard()
        for(index, row) in board.enumerated() {
            boardViews[index] = setupRow(row: row, y: index, minY: BoardView.frame.minY, minX:BoardView.frame.minX , height: BoardView.frame.height, totalWidth: BoardView.frame.width)
        }

    }

    func resetBoard(){
        guard let game = game else {return}
        boardViews.forEach { (row) in
            row.forEach { piece in
                piece.reset(text: game.defaultValue())
            }
        }
        game.newGame()
    }

    func setupRow(row: [String], y: Int, minY: CGFloat, minX: CGFloat, height: CGFloat, totalWidth: CGFloat) -> [BoardPieceView] {

        let incrementWidth = totalWidth / 6
        let incrementHeight = height / 6
        let trueY = minY + ((CGFloat.init(y) + 2) * incrementHeight/2) + (CGFloat.init(y) * incrementHeight)

        let frame1 = CGRect.init(x: minX + incrementWidth/2, y: trueY, width: incrementWidth, height: incrementHeight)
        let frame2 = CGRect.init(x: minX + incrementWidth/2 + incrementWidth*2, y: trueY, width: incrementWidth, height: incrementHeight)
        let frame3 = CGRect.init(x: minX + incrementWidth/2 + incrementWidth*4, y: trueY, width: incrementWidth, height: incrementHeight)

        let piece1 = BoardPieceView.init(frame: frame1, color: UIColor.lightGray, x: 0, y: y, initialText: row[0])
        piece1.delegate = self
        view.addSubview(piece1)

        let piece2 = BoardPieceView.init(frame: frame2, color: UIColor.lightGray, x: 1, y: y, initialText: row[0])
        piece2.delegate = self
        view.addSubview(piece2)

        let piece3 = BoardPieceView.init(frame: frame3, color: UIColor.lightGray, x: 2, y: y, initialText: row[0])
        piece3.delegate = self
        view.addSubview(piece3)

        return [piece1,piece2,piece3]

    }

}

extension TTTViewController: BoardPieceDelegate {
    func onTouch(view: BoardPieceView) {
        guard let game = game else {return}
        view.updateView(text: game.makeMove(posx: view.x, posy: view.y))
        if(game.solved()){
            resetBoard()
        }
    }
}
