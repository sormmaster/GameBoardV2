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
    var boardView: UIView
    var boardViews: [[BoardPieceView]] = []
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
        boardView = UIView()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        view.addSubview(boardView)
        boardView.backgroundColor = .darkGray
        boardView.translatesAutoresizingMaskIntoConstraints = false
        boardView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10).isActive = true
        boardView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, constant: -20).isActive = true
        boardView.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor).isActive = true
        boardView.heightAnchor.constraint(equalTo: boardView.widthAnchor).isActive = true

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupBoard() {
        guard let game = game else {return}
        game.newGame()

        for index in 0...2 {
            boardViews.append(setupRow(value: "-", y: index, minX: 0, minY: 0, height: boardView.frame.height, width: boardView.frame.width, squareSize: 3))
        }
    }

    func setupRow(value: String, y: Int, minX: CGFloat, minY: CGFloat, height: CGFloat, width: CGFloat, squareSize: CGFloat) -> [BoardPieceView] {

        let incrementWidth = width / ((squareSize * 2) + 1)
        let incrementHeight = height / ((squareSize * 2) + 1)

        var pieceArray: [BoardPieceView] = []

        for index in 0...Int(squareSize - 1) {
            let frameHeight = (((CGFloat(y) * 2.0) + 1) * incrementHeight + minY)
            let frameWidth = (((CGFloat(index) * 2.0) + 1) * incrementWidth + minX)
            let frame = CGRect(x: frameWidth , y:frameHeight , width: incrementWidth, height: incrementHeight)
            let piece = BoardPieceView(frame: frame, color: UIColor.lightGray, x: index, y: y, initialText: value)
            piece.delegate = self
            pieceArray.append(piece)
            boardView.addSubview(piece)
        }

        return pieceArray
    }

    func resetBoard(){
        allowInteractions = false
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: {_ in
            guard let game = self.game else {return}
            self.boardViews.forEach { (row) in
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
        let color = game.getTurn() ? UIColor.red : UIColor.blue
        view.updateView(text: game.makeMove(posx: view.x, posy: view.y), color: color)

        if(game.solved()){
            print(game.getTurn() ? "Player One" : "Player Two" + " Won")
            self.boardView.backgroundColor = game.getTurn() ? UIColor.red : UIColor.blue
            resetBoard()
        }

        if(!game.playable()){
            print("Nobody One The Game")
            resetBoard()
        }
    }
}
