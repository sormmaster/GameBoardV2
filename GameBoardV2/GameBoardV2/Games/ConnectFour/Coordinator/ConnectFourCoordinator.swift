//
//  ConnectFourCoordinator.swift
//  GameBoardV2
//
//  Created by Dylan Westfall on 5/19/20.
//  Copyright © 2020 practice. All rights reserved.
//

import Foundation
import UIKit

class ConnectFourCoordinator: Coordinator {

    var navigation: UINavigationController?
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    func start(){
       TTTFlow()
    }

    func TTTFlow(){
        let vc1: ConnectFourViewController = ConnectFourViewController.init()
        vc1.game = ConnectFourGame.init()
        vc1.coordinator = self
        navigation?.pushViewController(vc1, animated: true)
    }

    func drop() {
        navigation?.popViewController(animated: true)
        navigation = nil
    }
}
