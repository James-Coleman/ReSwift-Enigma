//
//  LightboardReducer.swift
//  ReSwift Enigma
//
//  Created by James Coleman on 16/07/2017.
//  Copyright © 2017 James Coleman. All rights reserved.
//

import ReSwift

struct OutputState: StateType {
    var currentLetter: String?
    var message: String = ""
    
}

extension OutputState: Equatable {
    static func == (lhs: OutputState, rhs: OutputState) -> Bool {
        return lhs.currentLetter == rhs.currentLetter && lhs.message == rhs.message
    }
}

func outputReducer(action: Action, state: OutputState?) -> OutputState {
    var state = state ?? OutputState()
    
    switch action {
    case let action as SelectLetter:
        state.currentLetter = action.letter
        state.message += action.letter
        
    case _ as ClearLetter:
        state.currentLetter = nil
        
    case _ as DeleteLetter:
        var currentMessage = state.message.characters
        currentMessage.popLast()
        let newMessage = String(currentMessage)
        
        state.message = newMessage
        
    default:
        break
    }
    
    return state
}
