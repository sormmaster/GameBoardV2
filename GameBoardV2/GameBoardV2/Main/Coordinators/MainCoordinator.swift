//
//  MainCoordinator.swift
//  GameBoardV2
//
//  Created by Dylan Westfall on 4/24/20.
//  Copyright © 2020 practice. All rights reserved.
//

import Foundation
import UIKit
class MainCoordinator: Coordinator {
    private var window: UIWindow
    private var navigation: UITabBarController
    private var childCoordinators: [Coordinator] = []
    init(window: UIWindow, navigation: UITabBarController){
        self.window = window
        self.navigation = navigation
    }

    /// Start for Main Coordinator intiations the tab bar and navigation stack to allow the user to both
    /// view match history and view the current gameplay without interuption.
    func start() {
        navigation.viewControllers = [tttFlow(),connectFourFlow(),historyFlow()]
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }

    private func  historyFlow() -> UINavigationController{
        let nav = UINavigationController.init()
        let vc = UIViewController.init()
        vc.view.backgroundColor = .white
        nav.pushViewController(vc, animated: false)
        nav.title = "History"
        vc.createWorkingOnLabel()
        return nav
    }

    private func tttFlow() -> UINavigationController{
        let nav = UINavigationController.init()
        let tttCoordinator = TTTCoordinator.init(navigation: nav)
        tttCoordinator.start()
        childCoordinators.append(tttCoordinator)
        nav.title = "Tic Tac Toe"
        return nav
    }

    private func connectFourFlow() -> UINavigationController{
        let nav = UINavigationController.init()
        let connectFourCoordinator = ConnectFourCoordinator.init(navigation: nav)
        connectFourCoordinator.start()
        childCoordinators.append(connectFourCoordinator)
        nav.title = "Connect Four"
        return nav
    }

    func drop() {
        fatalError("Cannot drop the Main Coordinator")
    }

}
