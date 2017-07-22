//
//  PlugboardReducer.swift
//  ReSwift Enigma
//
//  Created by James Coleman on 16/07/2017.
//  Copyright © 2017 James Coleman. All rights reserved.
//

import ReSwift

struct PlugboardState: StateType {
    var plugboard: [String:String] = ["A":"", "B":"", "C":"", "D":"", "E":"", "F":"", "G":"", "H":"", "I":"", "J":"", "K":"", "L":"", "M":"", "N":"", "O":"", "P":"", "Q":"", "R":"", "S":"", "T":"", "U":"", "V":"", "W":"", "X":"", "Y":"", "Z":""]
}

extension PlugboardState: Equatable {
    static func ==(lhs: PlugboardState, rhs: PlugboardState) -> Bool {
        return lhs.plugboard == rhs.plugboard
    }
}

func plugboardReducer(action: Action, state: PlugboardState?) -> PlugboardState {
    var state = state ?? PlugboardState()
    
    switch action {
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
