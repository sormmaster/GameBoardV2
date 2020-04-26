//
//  ViewController.swift
//  GameBoardV2
//
//  Created by Dylan Westfall on 4/25/20.
//  Copyright © 2020 practice. All rights reserved.
//

import UIKit
extension UIViewController {
    func createWorkingOnLabel() {
        let tempLabel = UILabel.init(frame: self.view.bounds)
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.text = "This page has yet to be implemeted, sorry for the inconvience."
        tempLabel.numberOfLines = 0
        self.view.addSubview(tempLabel)
        let margins = view.layoutMarginsGuide
        tempLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        tempLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        tempLabel.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        tempLabel.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true

    }
}
