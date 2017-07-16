//
//  WorkingReducer.swift
//  ReSwift Enigma
//
//  Created by James Coleman on 16/07/2017.
//  Copyright © 2017 James Coleman. All rights reserved.
//

import ReSwift

/*
struct WorkingState: StateType {
    var selectedLetter: String?
    
    var rightRotor: Rotor
    var centreRotor: Rotor
    var leftRotor: Rotor
    
    let reflector: Reflector
    
    var message: String
}

func initialWorkingState() -> WorkingState {    
    let setupState = mainStore.state.setupState
    
    // Right rotor
    
    let rightRotor = setupState.rightRotor
    let rightRotorType = rightRotor.type
    let rightRotorOffset = rightRotor.offset
    
    var rightRotorToUse = rotors[rightRotorType]
    
    if rightRotorOffset > 0 {
//        rightRotorToUse.offset = rightRotorOffset
        rightRotorToUse.wiring = advance(wiring: rightRotorToUse.wiring, by: rightRotorOffset)
    }
    
    // Centre rotor
    
    let centreRotor = setupState.centreRotor
    let centreRotorType = centreRotor.type
    let centreRotorOffset = centreRotor.offset
    
    var centreRotorToUse = rotors[centreRotorType]
    
    if centreRotorOffset > 0 {
//        centreRotorToUse.offset = centreRotorOffset
        centreRotorToUse.wiring = advance(wiring: centreRotorToUse.wiring, by: centreRotorOffset)
    }
    
    // Left rotor
    
    let leftRotor = setupState.leftRotor
    let leftRotorType = leftRotor.type
    let leftRotorOffset = leftRotor.offset
    
    var leftRotorToUse = rotors[leftRotorType]
    
    if leftRotorOffset > 0 {
//        leftRotorToUse.offset = leftRotorOffset
        leftRotorToUse.wiring = advance(wiring: leftRotorToUse.wiring, by: leftRotorOffset)
    }
    
    // Reflector
    
    let setupReflector = setupState.reflector
    
    return WorkingState(
        selectedLetter: nil,
        
        rightRotor: rightRotorToUse,
        centreRotor: centreRotorToUse,
        leftRotor: leftRotorToUse,
        
        reflector: reflectors[setupReflector],
        
        message: ""
    )
}

func workingReducer(action: Action, state: WorkingState?) -> WorkingState {
    var state = state ?? initialWorkingState()
    
    switch action {
    case let action as SelectLetter:
        state.message = state.message + action.letter
        state.selectedLetter = action.letter
        
    case _ as ClearLetter:
        state.selectedLetter = nil
        
    default:
        break
    }
    
    return state
}
*/

protocol Rotor {
//    var offset: Int { get set }
    var wiring: [String:String] { get set }
    var stepover: Int { get }
}

struct RotorI: Rotor {
//    var offset = 0
    // E K M F L G D Q V Z N T O W Y H X U S P A I B R C J
    var wiring = ["A":"E", "B":"K", "C":"M", "D":"F", "E":"L", "F":"G", "G":"D", "H":"Q", "I":"V", "J":"Z", "K":"N", "L":"T", "M":"O", "N":"W", "O":"Y", "P":"H", "Q":"X", "R":"U", "S":"S", "T":"P", "U":"A", "V":"I", "W":"B", "X":"R", "Y":"C", "Z":"J"]
    let stepover = 16 // "Q" ("A" == 0)
}

struct RotorII: Rotor {
//    var offset = 0
    // A J D K S I R U X B L H W T M C Q G Z N P Y F V O E
    var wiring = ["A":"A", "B":"J", "C":"D", "D":"K", "E":"S", "F":"I", "G":"R", "H":"U", "I":"X", "J":"B", "K":"L", "L":"H", "M":"W", "N":"T", "O":"M", "P":"C", "Q":"Q", "R":"G", "S":"Z", "T":"N", "U":"P", "V":"Y", "W":"F", "X":"V", "Y":"O", "Z":"E"]
    let stepover = 4 // "E" ("A" == 0)
}

struct RotorIII: Rotor {
//    var offset = 0
    // B D F H J L C P R T X V Z N Y E I W G A K M U S Q O
    var wiring = ["A":"B", "B":"D", "C":"F", "D":"H", "E":"J", "F":"L", "G":"C", "H":"P", "I":"R", "J":"T", "K":"X", "L":"V", "M":"Z", "N":"N", "O":"Y", "P":"E", "Q":"I", "R":"W", "S":"G", "T":"A", "U":"K", "V":"M", "W":"U", "X":"S", "Y":"Q", "Z":"O"]
    let stepover = 21 // "V" ("A" == 0)
}

protocol Reflector {
    var wiring: [String:String] { get }
}

struct ReflectorA: Reflector {
    // E J M Z A L Y X V B W F C R Q U O N T S P I K H G D
    var wiring: [String : String] = ["A":"E", "B":"J", "C":"M", "D":"Z", "E":"A", "F":"L", "G":"Y", "H":"X", "I":"V", "J":"B", "K":"W", "L":"F", "M":"C", "N":"R", "O":"Q", "P":"U", "Q":"O", "R":"N", "S":"T", "T":"S", "U":"P", "V":"I", "W":"K", "X":"H", "Y":"G", "Z":"D"]
}

struct ReflectorB: Reflector {
    // Y R U H Q S L D P X N G O K M I E B F Z C W V J A T
    var wiring: [String : String] = ["A":"Y", "B":"R", "C":"U", "D":"H", "E":"Q", "F":"S", "G":"L", "H":"D", "I":"P", "J":"X", "K":"N", "L":"G", "M":"O", "N":"K", "O":"M", "P":"I", "Q":"E", "R":"B", "S":"F", "T":"Z", "U":"C", "V":"W", "W":"V", "X":"J", "Y":"A", "Z":"T"]
}

struct ReflectorC: Reflector {
    // F V P J I A O Y E D R Z X W G C T K U Q S B N M H L
    var wiring: [String : String] = ["A":"F", "B":"V", "C":"P", "D":"J", "E":"I", "F":"A", "G":"O", "H":"Y", "I":"E", "J":"D", "K":"R", "L":"Z", "M":"X", "N":"W", "O":"G", "P":"C", "Q":"T", "R":"K", "S":"U", "T":"Q", "U":"S", "V":"B", "W":"N", "X":"M", "Y":"H", "Z":"L"]
}

let rotors: [Rotor] = [RotorI(), RotorII(), RotorIII()]
let reflectors: [Reflector] = [ReflectorA(), ReflectorB(), ReflectorC()]

let prevLetterDict: [String:String] = ["A":"Z", "B":"A", "C":"B", "D":"C", "E":"D", "F":"E", "G":"F", "H":"G", "I":"H", "J":"I", "K":"J", "L":"K", "M":"L", "N":"M", "O":"N", "P":"O", "Q":"P", "R":"Q", "S":"R", "T":"S", "U":"T", "V":"U", "W":"V", "X":"W", "Y":"X", "Z":"Y"]

func advance(wiring: [String: String], by: Int) -> [String:String] {
    if by <= 0 {
        return wiring
    }
    
    var varWiring = wiring
    
    for _ in 1...by {
        //        print("\(varRotor) : varRotor start")
        
        let nextRotorArray = varWiring.map { (key: String, value: String) -> [String:String] in
            let nextLetter = prevLetterDict[key]!
            let nextValue = prevLetterDict[value]!
            return [nextLetter:nextValue]
        }
        //        print(nextRotorArray)
        
        let nextRotor = nextRotorArray.reduce([:], { (dictionarySoFar, nextKeyValuePair) -> [String:String] in
            guard let first = nextKeyValuePair.first else { return [:] }
            var varDictionarySoFar = dictionarySoFar
            varDictionarySoFar[first.key] = first.value
            return varDictionarySoFar
        })
        
        //        print("\(nextRotor) : nextRotor")
        
        varWiring = nextRotor
        
        //        print("\(varRotor) : varRotor")
    }
    
    return varWiring
}

func reverse(wiring: [String:String]) -> [String:String] {
    let reverseArray = wiring.map { key, value in
        return [value: key]
    }
    
    let reverseDict = reverseArray.reduce([:]) { dictionarySoFar, nextKeyValuePair -> [String:String] in
        guard let first = nextKeyValuePair.first else { return [:] }
        var varDictionarySoFar = dictionarySoFar
        varDictionarySoFar[first.key] = first.value
        return varDictionarySoFar
    }
    
    return reverseDict
}
