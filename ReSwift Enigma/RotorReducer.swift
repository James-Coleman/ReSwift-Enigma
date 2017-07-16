//
//  RotorReducer.swift
//  ReSwift Enigma
//
//  Created by James Coleman on 16/07/2017.
//  Copyright © 2017 James Coleman. All rights reserved.
//

import ReSwift

struct RotorState: StateType {
    var reflectorRow: Int = 1
    
    var leftRotorRow: Int = 0
    var centreRotorRow: Int = 1
    var rightRotorRow: Int = 2
    
    var leftRotorOffset: Int = 0
    var centreRotorOffset: Int = 0
    var rightRotorOffset: Int = 0
    
    // Adjust for Enigma advancing row *before* encoding
    var adjustedLeftRotorOffset: Int {
        var offset = leftRotorOffset + 1
        while offset < 0 {
            offset += 26
        }
        return offset
    }
    var adjustedCentreRotorOffset: Int {
        var offset = centreRotorOffset + 1
        while offset < 0 {
            offset += 26
        }
        return offset
    }
    var adjustedRightRotorOffset: Int {
        var offset = rightRotorOffset + 1
        while offset < 0 {
            offset += 26
        }
        return offset
    }
    
    var reflector: Reflector {
        return reflectors[reflectorRow]
    }
    
    var leftRotor: Rotor {
        return rotors[leftRotorRow]
    }
    var centreRotor: Rotor {
        return rotors[centreRotorRow]
    }
    var rightRotor: Rotor {
        return rotors[rightRotorRow]
    }
    
    var leftWiring: [String:String] {
        return advance(wiring: leftRotor.wiring, by: leftRotorOffset)
    }
    var centreWiring: [String:String] {
        return advance(wiring: centreRotor.wiring, by: centreRotorOffset)
    }
    var rightWiring: [String:String] {
        return advance(wiring: rightRotor.wiring, by: adjustedRightRotorOffset)
    }
    
    var reverseLeftWiring: [String:String] {
        return reverse(wiring: leftWiring)
    }
    var reverseCentreWiring: [String:String] {
        return reverse(wiring: centreWiring)
    }
    var reverseRightWiring: [String:String] {
        return reverse(wiring: rightWiring)
    }
    
}

func rotorReducer(action: Action, state: RotorState?) -> RotorState {
    var state = state ?? RotorState()
    
    switch action {
    case let action as SetReflector:
        state.reflectorRow = action.reflector
        
    case let action as SetRotor:
        switch action.rotor {
        case .left:
            state.leftRotorRow = action.rotorNumber
        case .centre:
            state.centreRotorRow = action.rotorNumber
        case .right:
            state.rightRotorRow = action.rotorNumber
        }
        
    case let action as SetInitialPosition:
        switch action.rotor {
        case .left:
            state.leftRotorOffset = action.offset
        case .centre:
            state.centreRotorOffset = action.offset
        case .right:
            state.rightRotorOffset = action.offset
        }
        
    case _ as SelectLetter:
        state.rightRotorOffset += 1
        if state.rightRotorOffset > 25 {
            let remainder = state.rightRotorOffset % 26
            state.rightRotorOffset = remainder
        }
        
    default:
        break
    }
    
    return state
}
