//
//  RotorReducer.swift
//  ReSwift Enigma
//
//  Created by James Coleman on 16/07/2017.
//  Copyright © 2017 James Coleman. All rights reserved.
//

import ReSwift

enum RotorPosition {
    case
    left,
    centre,
    right
}

struct RotorState: StateType {
    var reflectorRow: Int = 1
    
    var leftRotorRow: Int = 0 // 2 in double step test
    var centreRotorRow: Int = 1
    var rightRotorRow: Int = 2 // 0 in double step test
    
    var leftRotorPin: Int = 0
    var centreRotorPin: Int = 0
    var rightRotorPin: Int = 0
    
    var leftRotorOffset: Int = 0
    var centreRotorOffset: Int = 0 // 3 : "D" (double step test)
    var rightRotorOffset: Int = 0 // 14 : "O" (double step test)
    
    var adjustedStepoverLeft: Int {
        var offset = leftRotor.stepover - leftRotorPin
        if offset > 25 {
            let remainder = offset % 26
            offset = remainder
        }
        while offset < 0 {
            offset += 26
        }
        return offset
    }
    var adjustedStepoverCentre: Int {
        var offset = centreRotor.stepover - centreRotorPin
        if offset > 25 {
            let remainder = offset % 26
            offset = remainder
        }
        while offset < 0 {
            offset += 26
        }
        return offset
    }
    var adjustedStepoverRight: Int {
        var offset = rightRotor.stepover - rightRotorPin
        log.debug("adjusted stepover right offset: \(offset), right stepover: \(rightRotor.stepover), right pin: \(rightRotorPin), current position: \(rightRotorOffset)")
        if offset > 25 {
            let remainder = offset % 26
            offset = remainder
        }
        while offset < 0 {
            offset += 26
        }
        return offset
    }
    
    // Adjust for Enigma advancing row *before* encoding
    // Should only happen if the rotor is due to stepover...
    var adjustedLeftRotorOffset: Int {
        let stepAdjustment = leftRotorOffset == adjustedStepoverLeft ? 1 : 0
        var offset = leftRotorOffset + stepAdjustment - leftRotorPin
        if offset > 25 {
            let remainder = offset % 26
            offset = remainder
        }
        // Don't think I need this while anymore, but keeping in for now for debugging.
        while offset < 0 {
            offset += 26
        }
        return offset
    }
    var adjustedCentreRotorOffset: Int {
        let stepAdjustment = leftRotorOffset == adjustedStepoverCentre ? 1 : 0
        var offset = centreRotorOffset + stepAdjustment - centreRotorPin
        if offset > 25 {
            let remainder = offset % 26
            offset = remainder
        }
        while offset < 0 {
            offset += 26
        }
        return offset
    }
    var adjustedRightRotorOffset: Int {
        let stepAdjustment = 1 // Right rotor will always step over
        var offset = rightRotorOffset + stepAdjustment - rightRotorPin
        if offset > 25 {
            let remainder = offset % 26
            offset = remainder
        }
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
        return advance(wiring: leftRotor.wiring, by: adjustedLeftRotorOffset)
    }
    var centreWiring: [String:String] {
        return advance(wiring: centreRotor.wiring, by: adjustedCentreRotorOffset)
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
        
    case let action as SetPinOffset:
        switch action.rotor {
        case .left:
            state.leftRotorPin = action.pinOffset
        case .centre:
            state.centreRotorPin = action.pinOffset
        case .right:
            state.rightRotorPin = action.pinOffset
        }
        
    case _ as SelectLetter:
        if state.centreRotorOffset == state.adjustedStepoverCentre {
//            log.debug("double step conditions: centre rotor offset: \(state.centreRotorOffset), centre rotor stepover: \(state.centreRotor.stepover), right rotor offset: \(state.rightRotorOffset), right rotor stepover: \(state.rightRotor.stepover)")
            
            state.leftRotorOffset += 1
            if state.leftRotorOffset > 26 {
                let remainder = state.leftRotorOffset % 26
                state.leftRotorOffset = remainder
            }
            
            // Here is the 'double-step'
            state.centreRotorOffset += 1
            if state.centreRotorOffset > 26 {
                let remainder = state.centreRotorOffset % 26
                state.centreRotorOffset = remainder
            }
            
//            log.debug("post double step conditions: centre rotor offset: \(state.centreRotorOffset), centre rotor stepover: \(state.centreRotor.stepover), right rotor offset: \(state.rightRotorOffset), right rotor stepover: \(state.rightRotor.stepover)")
        }
        
        if state.rightRotorOffset == state.adjustedStepoverRight {
            state.centreRotorOffset += 1
            if state.centreRotorOffset > 26 {
                let remainder = state.centreRotorOffset % 26
                state.centreRotorOffset = remainder
            }
        }
        
        state.rightRotorOffset += 1
        if state.rightRotorOffset > 25 {
            let remainder = state.rightRotorOffset % 26
            state.rightRotorOffset = remainder
        }
        
        
        
    case _ as DeleteLetter:
        state.rightRotorOffset -= 1
        while state.rightRotorOffset < 0 {
            state.rightRotorOffset += 26
        }
        
        if state.rightRotorOffset == state.rightRotor.stepover {
            log.debug("just centre stepback")
            state.centreRotorOffset -= 1
            while state.centreRotorOffset < 0 {
                state.centreRotorOffset += 26
            }
        }
        
        
        if state.centreRotorOffset == state.centreRotor.stepover + 1 && state.rightRotorOffset == state.rightRotor.stepover + 1 {
            log.debug("left and centre stepback")
            state.leftRotorOffset -= 1
            while state.leftRotorOffset < 0 {
                state.leftRotorOffset += 26
            }
            
            // Acount for double-step
            state.centreRotorOffset -= 1
            while state.centreRotorOffset < 0 {
                state.centreRotorOffset += 26
            }
        }

        
    default:
        break
    }
    
    return state
}
