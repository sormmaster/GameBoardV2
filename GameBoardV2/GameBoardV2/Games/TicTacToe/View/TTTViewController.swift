//
//  TTTViewController.swift
//  GameBoardV2
//
//  Created by Dylan Westfall on 4/25/20.
//  Copyright © 2020 practice. All rights reserved.
//

import UIKit

class TTTViewController: UIViewController {

    @IBOutlet weak var collection: UICollectionView!

    weak var coordinator: TTTCoordinator?
    var game: TicTacToeGame?

    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        collection.reloadData()
        let nib = UINib(nibName: "TTTCollectionViewCell", bundle: nil)
        collection.register(nib, forCellWithReuseIdentifier: "TTTCollectionViewCell")
    }
    override func viewDidAppear(_ animated: Bool) {
        guard let game = game else {return}

        game.makeMove(posx: 0, posy: 0)
        game.makeMove(posx: 1, posy: 0)
        game.makeMove(posx: 0, posy: 1)
        game.makeMove(posx: 2, posy: 2)
        game.makeMove(posx: 0, posy: 2)
    }

}

extension TTTViewController: UICollectionViewDelegate {

}

extension TTTViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TTTCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TTTCollectionViewCell", for: indexPath) as! TTTCollectionViewCell
        cell.updateLabel(value: "X")
        return cell
    }
}
