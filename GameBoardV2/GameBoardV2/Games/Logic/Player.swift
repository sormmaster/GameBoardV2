//
//  Player.swift
//  GameBoardV2
//
//  Created by Dylan Westfall on 5/23/20.
//  Copyright © 2020 practice. All rights reserved.
//

import Foundation
import UIKit

enum Player: String, CaseIterable {

    case playerOne = "Player One"
    case playerTwo = "Player Two"
    case playerThree = "Player Three"
    case playerFour = "Player Four"

    func giveValue() -> String {
        switch self {
        case .playerOne:
            return "X"
        case .playerTwo:
            return "O"
        case .playerThree:
            return "A"
        case .playerFour:
            return "B"
        }
    }

    func giveColor() -> UIColor {
        switch self {
            case .playerOne:
                return .red
            case .playerTwo:
                return .blue
            case .playerThree:
                return .green
            case .playerFour:
                return .brown
        }
    }

    func nextPlayer( count: Int) -> Player {
        if( count == 1) {
            return self
        } else  if(count == 2){
            switch self {
            case .playerOne:
                return .playerTwo
            case .playerTwo:
                return .playerOne
            case .playerThree:
                return .playerFour
            case .playerFour:
                return .playerThree
            }
        } else if(count == 3) {
            switch self {
            case .playerOne:
                return .playerTwo
            case .playerTwo:
                return .playerThree
            case .playerThree:
                return .playerOne
            case .playerFour:
                return .playerOne
            }
        } else {
            switch self {
            case .playerOne:
                return .playerTwo
            case .playerTwo:
                return .playerThree
            case .playerThree:
                return .playerFour
            case .playerFour:
                return .playerOne
            }
        }

    }
}
