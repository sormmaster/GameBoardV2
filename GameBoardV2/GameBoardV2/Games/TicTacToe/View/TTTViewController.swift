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
    @IBOutlet weak var TTTResetButton: UIButton!

    @IBAction func TTTResetClick(_ sender: Any) {
            resetBoard()
    }

    weak var coordinator: TTTCoordinator?

    var game: TicTacToeGame?
    var boardView: BoardGameView
    var allowInteractions = true

    override func viewDidAppear(_ animated: Bool) {
        setupBoard()
    }

    override func viewDidDisappear(_ animated: Bool) {
        for view in boardView.subviews {
            view.removeFromSuperview()
        }
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        boardView = BoardGameView(columns: 3, rows: 3)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        view.addSubview(boardView)
        boardView.setConstraints(parent: view)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupBoard() {
        guard let game = game else {return}
        game.newGame()
        game.gameDelegate = self
        boardView.setupRows(parent: self)
        
    }

    func resetBoard(){
        allowInteractions = false
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: {_ in
            guard let game = self.game else {return}
            self.boardView.getViews().forEach { (row) in
            row.forEach { piece in
                piece.reset(text: game.defaultValue())
            }
        }
            game.newGame()
            self.boardView.backgroundColor = UIColor.darkGray
            self.allowInteractions = true
        })
    }

}

extension TTTViewController: BoardPieceDelegate {
    func onTouch(view: BoardPieceView) {
        print("clickity click")
        guard allowInteractions, let game = game, game.validMove(posx: view.x, posy: view.y) else {return}
        let color = game.getTurn().giveColor()
        view.updateView(text: game.makeMove(posx: view.x, posy: view.y), color: color)
    }
}

extension TTTViewController: BoardGameDelegate {
    func gameOver(end: Player?) {
        guard let game = game else { return }
        if(game.solved()) {
            self.boardView.backgroundColor = game.getTurn().giveColor()
        }
        resetBoard()
    }

}
