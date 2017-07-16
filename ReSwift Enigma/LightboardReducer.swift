//
//  LightboardReducer.swift
//  ReSwift Enigma
//
//  Created by James Coleman on 16/07/2017.
//  Copyright © 2017 James Coleman. All rights reserved.
//

import ReSwift

struct LightboardState: StateType {
    var litBulb: String?
}

func lightboardReducer(action: Action, state: LightboardState?) -> LightboardState {
    var state = state ?? LightboardState()
    
    switch action {
    case let action as SelectLetter:
        state.litBulb = action.letter
        
    case _ as ClearLetter:
        state.litBulb = nil
        
    default:
        break
    }
    
    return state
}
