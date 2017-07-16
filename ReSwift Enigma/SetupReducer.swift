//
//  SetupReducer.swift
//  ReSwift Enigma
//
//  Created by James Coleman on 14/07/2017.
//  Copyright © 2017 James Coleman. All rights reserved.
//

import Foundation
import ReSwift

struct RotorSetup {
    var type: Int
    var offset: Int
}

/*
struct Rotors {
    var left = Rotor(type: 0, offset: 0)
    var centre = Rotor(type: 1, offset: 0)
    var right = Rotor(type: 2, offset: 0)
}
*/

/*
struct InitialRotors {
    var left = 0
    var centre = 1
    var right = 2
}

struct InitialOffset {
    var left = 0
    var centre = 0
    var right = 0
}
 */

struct SetupState: StateType {
    var reflector = 0
    
//    var leftRotor = 0
//    var centreRotor = 1
//    var rightRotor = 2
    
//    var rotors: [RotorPosition:Int] = [.left: 0, .centre: 1, .right: 2] // This was an idea but making this a dictionary makes the values optional, which made things messier overall...
    
    // Nested is probably not going to work either.
    /*
     struct Rotor {
     var left = 0
     var centre = 1
     var right = 2
     }
     */
    
    /*
    var rotors = InitialRotors()
    
    var offset = InitialOffset()
 */
    
    var leftRotor = RotorSetup(type: 0, offset: 0)
    var centreRotor = RotorSetup(type: 1, offset: 0)
    var rightRotor = RotorSetup(type: 2, offset: 0)
 
    var plugboard: [String:String] = ["A":"", "B":"", "C":"", "D":"", "E":"", "F":"", "G":"", "H":"", "I":"", "J":"", "K":"", "L":"", "M":"", "N":"", "O":"", "P":"", "Q":"", "R":"", "S":"", "T":"", "U":"", "V":"", "W":"", "X":"", "Y":"", "Z":""]
}

func setupReducer(action: Action, state: SetupState?) -> SetupState {
    var state = state ?? SetupState()
    
    switch action {
        
    case let action as SetReflector:
        state.reflector = action.reflector
        
    case let action as SetRotor:
        switch action.rotor {
        case .left:
            state.leftRotor.type = action.rotorNumber
        case .centre:
            state.centreRotor.type = action.rotorNumber
        case .right:
            state.rightRotor.type = action.rotorNumber
        }
        
    case let action as SetInitialPosition:
        switch action.rotor {
        case .left:
            state.leftRotor.offset = action.offset
        case .centre:
            state.centreRotor.offset = action.offset
        case .right:
            state.rightRotor.offset = action.offset
        }
        
    case let action as SetPlugboard:
        for (key, value) in state.plugboard {
            // If the value is already used somewhere else, clear it.
            if value == action.firstLetter {
                state.plugboard[key] = ""
            }
        }
        
        state.plugboard[action.firstLetter] = action.secondLetter
        state.plugboard[action.secondLetter] = action.firstLetter
        
    case let action as ClearPlugboardPorts:
        state.plugboard[action.firstLetter] = ""
        state.plugboard[action.secondLetter] = ""
        
    default:
        break
    }
    
    return state
}
