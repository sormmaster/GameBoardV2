//
//  BoardPieceView.swift
//  GameBoardV2
//
//  Created by Dylan Westfall on 5/1/20.
//  Copyright © 2020 practice. All rights reserved.
//

import UIKit
protocol BoardPieceDelegate: class {
    func onTouch(view: BoardPieceView)
}

class BoardPieceView: UIView {
    weak var delegate: BoardPieceDelegate?
    var currentColor: UIColor?
    var pieceLabel: UILabel?
    var defaultColor: UIColor
    var x: Int = 0
    var y: Int = 0

    init(frame: CGRect, color: UIColor, x: Int, y: Int, initialText: String) {
        self.defaultColor = color
        super.init(frame: frame)
        self.x = x
        self.y = y
        backgroundColor = color

        putLabel(text: initialText)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateView(text: String) {
        print("Setting " + String(self.x) + " " + String(self.y) + " to " + text )
        guard let pieceLabel = pieceLabel else {
            putLabel(text: text)
            return
        }
        pieceLabel.text = text
        print("label has: " + pieceLabel.text!)
    }

    func updateView(color: UIColor) {
        self.backgroundColor = color
    }

    func updateView(text: String, color: UIColor) {
        backgroundColor = color
        guard let pieceLabel = pieceLabel else {
            putLabel(text: text)
            return
        }
        pieceLabel.text = text
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.onTouch(view: self)
    }

    func reset(text: String) {
        guard let pieceLabel = pieceLabel else {
            print("could not assign label to view contraints")
            return
        }
        pieceLabel.text  = text
        backgroundColor = defaultColor
    }
    
    private func putLabel(text: String) {
        pieceLabel = UILabel.init(frame: CGRect.init(origin: .init(x: 0, y: 0), size: .init(width: self.frame.width, height: self.frame.height)))

        guard let pieceLabel = pieceLabel else {
            print("could not assign label to view constraints")
            return
        }

        pieceLabel.textAlignment = .center
        pieceLabel.text = text
        self.addSubview(pieceLabel)
    }
}
