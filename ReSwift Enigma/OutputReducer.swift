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
    static func ==(lhs: OutputState, rhs: OutputState) -> Bool {
        return lhs.currentLetter == rhs.currentLetter && lhs.message == rhs.message
    }
}

func outputReducer(action: Action, state: OutputState?) -> OutputState {
    var state = state ?? OutputState()
    
    let letterGrouping = 5
    
    switch action {
    case let action as SelectLetter:
        let spacelessMessage = state.message.characters.filter() { $0 != " " }
        
        if (spacelessMessage.count % letterGrouping == 0) && (spacelessMessage.count > 0) {
            state.message += " "
        }
        
        state.currentLetter = action.letter
        state.message += action.letter
        
    case _ as ClearLetter:
        state.currentLetter = nil
        
    case _ as DeleteLetter:
        var currentMessage = state.message.characters
        let _ = currentMessage.popLast()
        
        if currentMessage.last == " " {
            let _ = currentMessage.popLast()
        }
        
        let newMessage = String(currentMessage)
        
        state.message = newMessage
        
    default:
        break
    }
    
    return state
}
