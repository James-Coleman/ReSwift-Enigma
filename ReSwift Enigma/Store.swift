//
//  Store.swift
//  ReSwift Enigma
//
//  Created by James Coleman on 13/07/2017.
//  Copyright © 2017 James Coleman. All rights reserved.
//

import ReSwift

let mainStore = Store<AppState>(
    reducer: appReducer,
    state: nil
)

struct AppState: StateType {
    let rotorState: RotorState
    let plugboardState: PlugboardState
    let outputState: OutputState
    let navigationState: NavigationState
}

func appReducer(action: Action, state: AppState?) -> AppState {
//    log.debug("appReducer state: \(String(describing: state))")
    
    switch action {
    case _ as DebugResetState:
        return AppState(
            rotorState: RotorState(),
            plugboardState: PlugboardState(),
            outputState: OutputState(),
            navigationState: NavigationState()
        )
    default:
        return AppState(
            rotorState: rotorReducer(action: action, state: state?.rotorState),
            plugboardState: plugboardReducer(action: action, state: state?.plugboardState),
            outputState: outputReducer(action: action, state: state?.outputState),
            navigationState: navigationReducer(action: action, state: state?.navigationState)
        )
    }
    
}

struct DebugResetState: Action {}
