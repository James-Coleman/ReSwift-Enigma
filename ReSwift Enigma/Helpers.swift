//
//  Helpers.swift
//  ReSwift Enigma
//
//  Created by James Coleman on 18/07/2017.
//  Copyright © 2017 James Coleman. All rights reserved.
//

import Foundation

class Helpers {
    
    public static func advance(wiring: [String: String], by: Int) -> [String:String] {
        if by <= 0 {
            return wiring
        }
        
        var varWiring = wiring
        
        for _ in 1...by {
            // log.verbose("\(varWiring) : varWiring start")
            
            let nextWiringArray = varWiring.map { (key: String, value: String) -> [String:String] in
                let nextLetter = Data.prevLetterDict[key]!
                let nextValue = Data.prevLetterDict[value]!
                return [nextLetter:nextValue]
            }
            //        print(nextRotorArray)
            
            let nextWiring = nextWiringArray.reduce([:], { (dictionarySoFar, nextKeyValuePair) -> [String:String] in
                guard let first = nextKeyValuePair.first else { return [:] }
                var varDictionarySoFar = dictionarySoFar
                varDictionarySoFar[first.key] = first.value
                return varDictionarySoFar
            })
            
            // log.verbose("\(nextWiring) : nextWiring")
            
            varWiring = nextWiring
            
            //        print("\(varRotor) : varRotor")
        }
        
        return varWiring
    }
    
    public static func reverse(wiring: [String:String]) -> [String:String] {
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
    
    public static func encode(_ letter: String) -> String? {
        let rotorState = mainStore.state.rotorState
        
        let plugboard = mainStore.state.plugboardState.plugboard
        
        let rightWiring = rotorState.rightWiring
        let centreWiring = rotorState.centreWiring
        let leftWiring = rotorState.leftWiring
        
        //        log.debug(rotorState.rightRotor.wiring)
        //        log.debug(rotorState.rightWiring)
        
        let reverseRightWiring = rotorState.reverseRightWiring
        let reverseCentreWiring = rotorState.reverseCentreWiring
        let reverseLeftWiring = rotorState.reverseLeftWiring
        
        guard let plugboardOutLetter = plugboard[letter] else {
            log.error("no plugboard out letter from \(letter)")
            return nil
        }
        
        let actualPlugboardOutLetter = plugboardOutLetter == "" ? letter : plugboardOutLetter
        
        guard let rightLetter = rightWiring[actualPlugboardOutLetter] else {
            log.error("no right letter from \(actualPlugboardOutLetter)")
            return nil
        }
        guard let centreLetter = centreWiring[rightLetter] else {
            log.error("no centre letter from \(rightLetter)")
            return nil
        }
        guard let leftLetter = leftWiring[centreLetter] else {
            log.error("no left letter from \(centreLetter)")
            return nil
        }
        
        guard let reflectedLetter = rotorState.reflector.wiring[leftLetter] else {
            log.error("no reflected letter from \(leftLetter)")
            return nil
        }
        
        guard let reflectedLeftLetter = reverseLeftWiring[reflectedLetter] else {
            log.error("no reflected left letter from \(reflectedLetter)")
            return nil
        }
        guard let reflectedCentreLetter = reverseCentreWiring[reflectedLeftLetter] else {
            log.error("no reflected centre letter from \(reflectedLeftLetter)")
            return nil
        }
        guard let reflectedRightLetter = reverseRightWiring[reflectedCentreLetter] else {
            log.error("no reflected right letter from \(reflectedCentreLetter)")
            return nil
        }
        
        guard let plugboardInLetter = plugboard[reflectedRightLetter] else {
            log.error("no plugboard out letter from \(reflectedRightLetter)")
            return nil
        }
        
        let actualPlugboardInLetter = plugboardInLetter == "" ? reflectedRightLetter : plugboardInLetter
        
        log.info("\(letter), \(plugboardOutLetter), \(actualPlugboardOutLetter), \(rightLetter), \(centreLetter), \(leftLetter), \(reflectedLetter), \(reflectedLeftLetter), \(reflectedCentreLetter), \(reflectedRightLetter), \(plugboardInLetter), \(actualPlugboardInLetter)")
        
        return actualPlugboardInLetter
    }
    
}
