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
        navigation.viewControllers = [gameFlow(),historyFlow()]
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }

    private func  historyFlow() -> UINavigationController{
        let nav2 = UINavigationController.init()
        let vc2 = UIViewController.init()
        vc2.view.backgroundColor = .white
        nav2.pushViewController(vc2, animated: false)
        nav2.title = "History"
        vc2.createWorkingOnLabel()
        return nav2
    }

    private func gameFlow() -> UINavigationController{
        let nav1 = UINavigationController.init()
        let tttCoordinator = TTTCoordinator.init(navigation: nav1)
        tttCoordinator.start()
        childCoordinators.append(tttCoordinator)
        nav1.title = "Games"
        return nav1
    }

    func drop() {
        fatalError("Cannot drop the Main Coordinator")
    }

}
