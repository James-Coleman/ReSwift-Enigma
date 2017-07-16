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
    let setupState: SetupState
    let workingState: WorkingState
}

func appReducer(action: Action, state: AppState?) -> AppState {
    log.debug("appReducer state: \(String(describing: state))")
    return AppState(
        setupState: setupReducer(action: action, state: state?.setupState),
        workingState: workingReducer(action: action, state: state?.workingState)
    )
}

struct AdvanceRotor: Action {
    let rotor: RotorPosition
    let advanceBy: Int
}

enum RotorPosition {
    case
    left,
    centre,
    right
}
