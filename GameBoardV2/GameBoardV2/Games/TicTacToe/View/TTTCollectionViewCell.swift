//
//  TTTCollectionViewCell.swift
//  GameBoardV2
//
//  Created by Dylan Westfall on 4/25/20.
//  Copyright © 2020 practice. All rights reserved.
//

import UIKit

class TTTCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var TTTCellValue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateLabel(value: String) {
        TTTCellValue.text = value
    }
}
