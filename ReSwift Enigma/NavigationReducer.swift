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

extension NavigationState: Equatable {
    static func ==(lhs: NavigationState, rhs: NavigationState) -> Bool {
        return lhs.navigationStack == rhs.navigationStack
    }
}

func navigationReducer(action: Action, state: NavigationState?) -> NavigationState {
    var state = state ?? NavigationState()
    
    switch action {
    case let action as NavigateTo:
        state.navigationStack.append(action.screen)
    case _ as PopBack:
        let _ = state.navigationStack.popLast()
    default:
        break
    }
    
    return state
}
