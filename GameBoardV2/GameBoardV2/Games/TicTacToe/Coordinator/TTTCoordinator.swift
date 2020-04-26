//
//  TTTCoordinator.swift
//  GameBoardV2
//
//  Created by Dylan Westfall on 4/24/20.
//  Copyright © 2020 practice. All rights reserved.
//

import Foundation
import UIKit

class TTTCoordinator: Coordinator {

    var navigation: UINavigationController?
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    func start(){
       TTTFlow()
    }

    func TTTFlow(){
        let vc1: TTTViewController = TTTViewController.init()
        vc1.game = TicTacToeGame.init()
        vc1.coordinator = self
        navigation?.pushViewController(vc1, animated: true)
    }

    func drop() {
        navigation?.popViewController(animated: true)
        navigation = nil
    }
}
