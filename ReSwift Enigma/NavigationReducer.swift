//
//  NavigationReducer.swift
//  ReSwift Enigma
//
//  Created by James Coleman on 18/07/2017.
//  Copyright © 2017 James Coleman. All rights reserved.
//

import ReSwift

enum Screen: String {
    case SetupViewController
    case CodeViewController
}

struct NavigationState {
    var navigationStack: [Screen] = [.SetupViewController]
}

func navigationReducer(action: Action, state: NavigationState?) -> NavigationState {
    var state = state ?? NavigationState()
    
    switch action {
    case let action as NavigateTo:
        state.navigationStack.append(action.screen)
    case _ as PopBack:
        state.navigationStack.popLast()
    default:
        break
    }
    
    return state
}
