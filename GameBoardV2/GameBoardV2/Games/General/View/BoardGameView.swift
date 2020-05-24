//
//  BoardGameView.swift
//  GameBoardV2
//
//  Created by Dylan Westfall on 5/23/20.
//  Copyright © 2020 practice. All rights reserved.
//

import UIKit

class BoardGameView: UIView {

    private var boardViews: [[BoardPieceView]] = []
    private var columns: Int
    private var rows: Int

    override init(frame: CGRect) {
        columns = 7
        rows = 6
        super.init(frame: frame)
    }

    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
        super.init(frame: CGRect())
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setConstraints(parent: UIView) {
        backgroundColor = .darkGray
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: parent.layoutMarginsGuide.leadingAnchor, constant: 10).isActive = true
        widthAnchor.constraint(equalTo: parent.layoutMarginsGuide.widthAnchor, constant: -20).isActive = true
        centerYAnchor.constraint(equalTo: parent.layoutMarginsGuide.centerYAnchor).isActive = true
        heightAnchor.constraint(equalTo: widthAnchor).isActive = true
    }

    func setupRow(value: String, y: Int, minX: CGFloat, minY: CGFloat, height: CGFloat, width: CGFloat, parent: BoardPieceDelegate) -> [BoardPieceView] {

        let incrementWidth = width / (CGFloat(rows * 2) + 1)
        let incrementHeight = height / (CGFloat(columns * 2) + 1)

        var pieceArray: [BoardPieceView] = []

        for index in 0 ... (rows - 1) {
            let frameHeight = (((CGFloat(y) * 2.0) + 1) * incrementHeight + minY)
            let frameWidth = (((CGFloat(index) * 2.0) + 1) * incrementWidth + minX)
            let frame = CGRect(x: frameWidth , y:frameHeight , width: incrementWidth, height: incrementHeight)
            let piece = BoardPieceView(frame: frame, color: UIColor.lightGray, x: index, y: y, initialText: value)
            piece.delegate = parent
            pieceArray.append(piece)
            addSubview(piece)
        }

        return pieceArray
    }

    func setupColumns(parent: BoardPieceDelegate){
        for index in 0 ... (columns - 1) {
            boardViews.append(setupRow(value: "-", y: index, minX: 0, minY: 0, height: frame.height, width: frame.width, parent: parent))
        }
    }

    func getViews() -> [[BoardPieceView]] {
        return boardViews
    }
}
