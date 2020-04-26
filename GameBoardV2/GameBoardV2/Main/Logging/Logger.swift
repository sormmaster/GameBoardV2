//
//  Logger.swift
//  GameBoardV2
//
//  Created by Dylan Westfall on 4/25/20.
//  Copyright © 2020 practice. All rights reserved.
//

import Foundation

class Logger {
    func println(values: [String]) {
        print("===== start log =====")
        for statement in values {
            print(statement)
        }
        print("==== end log =====")
    }
}
