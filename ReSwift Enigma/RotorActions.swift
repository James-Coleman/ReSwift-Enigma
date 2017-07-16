//
//  RotorActions.swift
//  ReSwift Enigma
//
//  Created by James Coleman on 16/07/2017.
//  Copyright © 2017 James Coleman. All rights reserved.
//

import ReSwift

struct SetReflector: Action {
    let reflector: Int
}

struct SetRotor: Action {
    let rotor: RotorPosition
    let rotorNumber: Int
}

struct SetInitialPosition: Action {
    let rotor: RotorPosition
    let offset: Int
}
