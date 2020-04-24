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
    init(window: UIWindow, navigation: UITabBarController){
        self.window = window
        self.navigation = navigation
    }

    /// Start for Main Coordinator intiations the tab bar and navigation stack to allow the user to both
    /// view match history and view the current gameplay without interuption.
    func start() {
        let nav1 = UINavigationController.init()
        let nav2 = UINavigationController.init()

        let vc1 = UIViewController.init()
        let vc2 = UIViewController.init()
        vc1.view.backgroundColor = UIColor.blue
        vc2.view.backgroundColor = UIColor.red

        nav1.pushViewController(vc1, animated: false)
        nav2.pushViewController(vc2, animated: false)
        nav1.title = "Games"
        nav2.title = "History"

        navigation.viewControllers = [nav1,nav2]
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }

    func drop() {
        print("Cannot dop the Main Coordinator")
    }

}
