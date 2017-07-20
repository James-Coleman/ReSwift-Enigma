//
//  EnigmaData.swift
//  ReSwift Enigma
//
//  Created by James Coleman on 18/07/2017.
//  Copyright © 2017 James Coleman. All rights reserved.
//

import Foundation

struct Rotor {
    var wiring: [String:String]
    var stepover: Int
}

struct Reflector {
    var wiring: [String:String]
}

class Data {
    
    public static let alphabet = ["A","B","C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    public static var alphabetCount: Int {
        return alphabet.count
    }
    
    public static let prevLetterDict: [String:String] = ["A":"Z", "B":"A", "C":"B", "D":"C", "E":"D", "F":"E", "G":"F", "H":"G", "I":"H", "J":"I", "K":"J", "L":"K", "M":"L", "N":"M", "O":"N", "P":"O", "Q":"P", "R":"Q", "S":"R", "T":"S", "U":"T", "V":"U", "W":"V", "X":"W", "Y":"X", "Z":"Y"]
    
    /// E K M F L G D Q V Z N T O W Y H X U S P A I B R C J
    public static let rotorI = Rotor(
        wiring: ["A":"E", "B":"K", "C":"M", "D":"F", "E":"L", "F":"G", "G":"D", "H":"Q", "I":"V", "J":"Z", "K":"N", "L":"T", "M":"O", "N":"W", "O":"Y", "P":"H", "Q":"X", "R":"U", "S":"S", "T":"P", "U":"A", "V":"I", "W":"B", "X":"R", "Y":"C", "Z":"J"],
        stepover: 16 // "Q" ("A" == 0)
    )
    
    /// A J D K S I R U X B L H W T M C Q G Z N P Y F V O E
    public static let rotorII = Rotor(
        wiring: ["A":"A", "B":"J", "C":"D", "D":"K", "E":"S", "F":"I", "G":"R", "H":"U", "I":"X", "J":"B", "K":"L", "L":"H", "M":"W", "N":"T", "O":"M", "P":"C", "Q":"Q", "R":"G", "S":"Z", "T":"N", "U":"P", "V":"Y", "W":"F", "X":"V", "Y":"O", "Z":"E"],
        stepover: 4 // "E" ("A" == 0)
    )
    
    /// B D F H J L C P R T X V Z N Y E I W G A K M U S Q O
    public static let rotorIII = Rotor(
        wiring: ["A":"B", "B":"D", "C":"F", "D":"H", "E":"J", "F":"L", "G":"C", "H":"P", "I":"R", "J":"T", "K":"X", "L":"V", "M":"Z", "N":"N", "O":"Y", "P":"E", "Q":"I", "R":"W", "S":"G", "T":"A", "U":"K", "V":"M", "W":"U", "X":"S", "Y":"Q", "Z":"O"],
        stepover: 21 // "V" ("A" == 0)
    )
    
    /// E J M Z A L Y X V B W F C R Q U O N T S P I K H G D
    public static let reflectorA = Reflector(
        wiring: ["A":"E", "B":"J", "C":"M", "D":"Z", "E":"A", "F":"L", "G":"Y", "H":"X", "I":"V", "J":"B", "K":"W", "L":"F", "M":"C", "N":"R", "O":"Q", "P":"U", "Q":"O", "R":"N", "S":"T", "T":"S", "U":"P", "V":"I", "W":"K", "X":"H", "Y":"G", "Z":"D"]
    )
    
    /// Y R U H Q S L D P X N G O K M I E B F Z C W V J A T
    public static let reflectorB = Reflector(
        wiring: ["A":"Y", "B":"R", "C":"U", "D":"H", "E":"Q", "F":"S", "G":"L", "H":"D", "I":"P", "J":"X", "K":"N", "L":"G", "M":"O", "N":"K", "O":"M", "P":"I", "Q":"E", "R":"B", "S":"F", "T":"Z", "U":"C", "V":"W", "W":"V", "X":"J", "Y":"A", "Z":"T"]
    )
    
    /// F V P J I A O Y E D R Z X W G C T K U Q S B N M H L
    public static let reflectorC = Reflector(
        wiring: ["A":"F", "B":"V", "C":"P", "D":"J", "E":"I", "F":"A", "G":"O", "H":"Y", "I":"E", "J":"D", "K":"R", "L":"Z", "M":"X", "N":"W", "O":"G", "P":"C", "Q":"T", "R":"K", "S":"U", "T":"Q", "U":"S", "V":"B", "W":"N", "X":"M", "Y":"H", "Z":"L"]
    )
    
    public static let rotors: [Rotor] = [rotorI, rotorII, rotorIII]
    
    public static let reflectors: [Reflector] = [reflectorA, reflectorB, reflectorC]
    
}
