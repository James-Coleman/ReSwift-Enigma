//
//  PlugboardActions.swift
//  ReSwift Enigma
//
//  Created by James Coleman on 16/07/2017.
//  Copyright © 2017 James Coleman. All rights reserved.
//

import ReSwift

struct SetPlugboard: Action {
    let firstLetter: String
    let secondLetter: String
}

struct ClearPlugboardPorts: Action {
    let firstLetter: String
    let secondLetter: String
}
