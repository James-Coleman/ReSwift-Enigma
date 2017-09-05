//
//  ReSwift_Enigma_Tests.swift
//  ReSwift Enigma Tests
//
//  Created by James Coleman on 20/07/2017.
//  Copyright © 2017 James Coleman. All rights reserved.
//

import XCTest
@testable import ReSwift_Enigma

class ReSwift_Enigma_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mainStore.dispatch(DebugResetState())
        super.tearDown()
    }
    
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
    // MARK: - Basic Encoding

    func testReverseDict() {
        let before = ["A":"E", "B":"K", "C":"M", "D":"F", "E":"L", "F":"G", "G":"D", "H":"Q", "I":"V", "J":"Z", "K":"N", "L":"T", "M":"O", "N":"W", "O":"Y", "P":"H", "Q":"X", "R":"U", "S":"S", "T":"P", "U":"A", "V":"I", "W":"B", "X":"R", "Y":"C", "Z":"J"] // Rotor I as example
        let after = ["E":"A", "K":"B", "M":"C", "F":"D", "L":"E", "G":"F", "D":"G", "Q":"H", "V":"I", "Z":"J", "N":"K", "T":"L", "O":"M", "W":"N", "Y":"O", "H":"P", "X":"Q", "U":"R", "S":"S", "P":"T", "A":"U", "I":"V", "B":"W", "R":"X", "C":"Y", "J":"Z"]
        
        let reversed = Helpers.reverse(wiring: before)
        
        XCTAssert(reversed == after)
    }
 
    func testAlphabetCount() {
        XCTAssert(Data.alphabetCount == 26)
    }
    
    func testAdvance() {
        let before = ["H": "P", "X": "S", "D": "H", "J": "T", "I": "R", "M": "Z", "Z": "O", "S": "G", "A": "B", "C": "F", "N": "N", "Y": "Q", "R": "W", "G": "C", "E": "J", "V": "M", "U": "K", "L": "V", "B": "D", "K": "X", "F": "L", "O": "Y", "W": "U", "T": "A", "P": "E", "Q": "I"]
        let after = ["H": "Q", "X": "P", "D": "I", "J": "W", "I": "S", "M": "M", "Z": "A", "S": "Z", "A": "C", "C": "G", "N": "X", "Y": "N", "R": "F", "G": "O", "E": "K", "V": "T", "U": "L", "L": "Y", "B": "E", "W": "R", "F": "B", "K": "U", "O": "D", "T": "J", "P": "H", "Q": "V"]
        
        let advanced = Helpers.advance(wiring: before, by: 1)
        
        XCTAssert(advanced == after)
    }
    
    func testEncode() {
        mainStore.dispatch(SetInitialPosition(rotor: .right, offset: 25)) // In this example, the initial rotor position is A A Z
        
        let rotorState = mainStore.state.rotorState
        
        let plugboard = mainStore.state.plugboardState.plugboard
        
        let rightWiring = rotorState.rightWiring
        let centreWiring = rotorState.centreWiring
        let leftWiring = rotorState.leftWiring
        
        let reverseRightWiring = rotorState.reverseRightWiring
        let reverseCentreWiring = rotorState.reverseCentreWiring
        let reverseLeftWiring = rotorState.reverseLeftWiring
        
        let letter = "G" // Using example from https://www.codesandciphers.org.uk/enigma/example1.htm
        
        guard let plugboardLetter = plugboard[letter] else {
            XCTAssertTrue(false, "No plugboard letter from \(letter)")
            return
        }
        
        let actualPlugboardLetter = plugboardLetter == "" ? letter : plugboardLetter
        
        guard let rightLetter = rightWiring[actualPlugboardLetter] else {
            XCTAssertTrue(false, "No right letter from \(actualPlugboardLetter)")
            return
        }
        guard let centreLetter = centreWiring[rightLetter] else {
            XCTAssertTrue(false, "No centre letter from \(rightLetter)")
            return
        }
        guard let leftLetter = leftWiring[centreLetter] else {
            XCTAssertTrue(false, "No left letter from \(centreLetter)")
            return
        }
        
        guard let reflectedLetter = rotorState.reflector.wiring[leftLetter] else {
            XCTAssertTrue(false, "No reflected letter from \(leftLetter)")
            return
        }
        
        guard let reflectedLeftLetter = reverseLeftWiring[reflectedLetter] else {
            XCTAssertTrue(false, "No reflected left letter from \(reflectedLetter)")
            return
        }
        guard let reflectedCentreLetter = reverseCentreWiring[reflectedLeftLetter] else {
            XCTAssertTrue(false, "No reflected centre letter from \(reflectedLeftLetter)")
            return
        }
        guard let reflectedRightLetter = reverseRightWiring[reflectedCentreLetter] else {
            XCTAssertTrue(false, "No reflected right letter from \(reflectedCentreLetter)")
            return
        }
        
        guard let reflectedPlugboardLetter = plugboard[reflectedRightLetter] else {
            XCTAssertTrue(false, "No reflected plugboard letter from \(reflectedRightLetter)")
            return
        }
        
        let actualReflectedPlugboardLetter = reflectedPlugboardLetter == "" ? reflectedRightLetter : reflectedPlugboardLetter

        XCTAssert(plugboardLetter                   == "")
        XCTAssert(actualPlugboardLetter             == "G")
        XCTAssert(rightLetter                       == "C")
        XCTAssert(centreLetter                      == "D")
        XCTAssert(leftLetter                        == "F")
        XCTAssert(reflectedLetter                   == "S")
        XCTAssert(reflectedLeftLetter               == "S")
        XCTAssert(reflectedCentreLetter             == "E")
        XCTAssert(reflectedRightLetter              == "P")
        XCTAssert(reflectedPlugboardLetter          == "")
        XCTAssert(actualReflectedPlugboardLetter    == "P")
    }
    
    // MARK: - Navigation Actions
    
    func testNavigateTo() {
        let beforeNavigationStack: [Screen] = [.SetupViewController]
        let afterNavigationStack: [Screen] = [.SetupViewController, .CodeViewController]
        
        XCTAssert(mainStore.state.navigationState.navigationStack == beforeNavigationStack, "Initial navigation state does not equal expected value")
        
        mainStore.dispatch(NavigateTo(screen: .CodeViewController))
        
        XCTAssert(mainStore.state.navigationState.navigationStack == afterNavigationStack, "NavigateTo action has not affected navigation state correctly")
    }
    
    func testPopBack() {
        let beforeNavigationStack: [Screen] = [.SetupViewController]
        let afterNavigationStack: [Screen] = [.SetupViewController, .CodeViewController]
        
        XCTAssert(mainStore.state.navigationState.navigationStack == beforeNavigationStack, "Initial navigation state does not equal expected value")
        
        mainStore.dispatch(NavigateTo(screen: .CodeViewController))
        
        XCTAssert(mainStore.state.navigationState.navigationStack == afterNavigationStack, "NavigateTo action has not affected navigation state correctly")
        
        mainStore.dispatch(PopBack())
        
        XCTAssert(mainStore.state.navigationState.navigationStack == beforeNavigationStack, "Last screen has not been removed from navigation state stack")
    }
    
    // MARK: - Output Actions
    
    func testSelectLetter() {
        let beforeOutputState = OutputState(currentLetter: nil, message: "")
        
        XCTAssert(mainStore.state.outputState == beforeOutputState, "Initial output state does not match expected values")
        
        let afterOutputState = OutputState(currentLetter: "A", message: "A")
        
        mainStore.dispatch(SelectLetter(letter: "A"))
        
        XCTAssert(mainStore.state.outputState == afterOutputState, "Dispatching a SelectLetter action has not updated the outputState correctly.")
        
        let lastOutputState = OutputState(currentLetter: "B", message: "AB")
        
        mainStore.dispatch(SelectLetter(letter: "B"))
        
        XCTAssert(mainStore.state.outputState == lastOutputState, "Dispatching another SelectLetter action has not properly updated the output state.")
    }
    
    func testClearLetter() {
        let beforeOutputState = OutputState(currentLetter: nil, message: "")
        
        XCTAssert(mainStore.state.outputState == beforeOutputState, "Initial output state does not match expected values")
        
        let afterOutputState = OutputState(currentLetter: "A", message: "A")
        
        mainStore.dispatch(SelectLetter(letter: "A"))
        
        XCTAssert(mainStore.state.outputState == afterOutputState, "Dispatching a SelectLetter action has not updated the outputState correctly.")
        
        mainStore.dispatch(ClearLetter())
        
        let lastOutputState = OutputState(currentLetter: nil, message: "A")
        
        XCTAssert(mainStore.state.outputState == lastOutputState, "ClearLetter action has not cleared the outputLetter of the output state")
    }
    
    func testDeleteLetter() {
        let beforeOutputState = OutputState(currentLetter: nil, message: "")
        
        XCTAssert(mainStore.state.outputState == beforeOutputState, "Initial output state does not match expected values")
        
        let afterOutputState = OutputState(currentLetter: "A", message: "A")
        
        mainStore.dispatch(SelectLetter(letter: "A"))
        
        XCTAssert(mainStore.state.outputState == afterOutputState, "Dispatching a SelectLetter action has not updated the outputState correctly.")
        
        mainStore.dispatch(DeleteLetter())
        
        let lastOutputState = OutputState(currentLetter: "A", message: "")
        
        XCTAssert(mainStore.state.outputState == lastOutputState, "Delete Letter action has not reverted output state to it's original version.")
    }
    
    // MARK: - Plugboard Actions
    
    func testSetPlugboard() {
        let initialPlugboardState = PlugboardState()
        
        XCTAssert(mainStore.state.plugboardState == initialPlugboardState, "The initial plugboard state is not the expected default")
        
        mainStore.dispatch(SetPlugboard(firstLetter: "A", secondLetter: "B"))
        
        XCTAssert(mainStore.state.plugboardState.plugboard["A"] == "B")
        XCTAssert(mainStore.state.plugboardState.plugboard["B"] == "A")
        
        mainStore.dispatch(SetPlugboard(firstLetter: "B", secondLetter: "C"))
        
        XCTAssert(mainStore.state.plugboardState.plugboard["B"] == "C")
        XCTAssert(mainStore.state.plugboardState.plugboard["C"] == "B")
        
        XCTAssert(mainStore.state.plugboardState.plugboard["A"] == "", "'A' has not been reset to ''")
    }
    
    func testClearPlugboardPorts() {
        let initialPlugboardState = PlugboardState()
        
        XCTAssert(mainStore.state.plugboardState == initialPlugboardState, "The initial plugboard state is not the expected default")
        
        mainStore.dispatch(SetPlugboard(firstLetter: "A", secondLetter: "B"))
        
        XCTAssert(mainStore.state.plugboardState.plugboard["A"] == "B", "Plugboard port 'A' has not been set correctly")
        XCTAssert(mainStore.state.plugboardState.plugboard["B"] == "A", "Plugboard port 'B' has not been set correctly")
        
        mainStore.dispatch(ClearPlugboardPorts(firstLetter: "A", secondLetter: "B"))
        
        XCTAssert(mainStore.state.plugboardState.plugboard["A"] == "", "Plugboard port 'A' has not been cleared")
        XCTAssert(mainStore.state.plugboardState.plugboard["B"] == "", "Plugboard port 'B' has not been cleared")
    }
    
    // MARK: - Rotor Actions
    
    func testSetReflector() {
        let initialRotorState = RotorState()
        
        XCTAssert(mainStore.state.rotorState == initialRotorState, "The initial rotor state is not the expected default")
        
        mainStore.dispatch(SetReflector(reflector: 2))
        
        let newRotorState = RotorState(reflectorRow: 2, leftRotorRow: 0, centreRotorRow: 1, rightRotorRow: 2, leftRotorPin: 0, centreRotorPin: 0, rightRotorPin: 0, leftRotorOffset: 0, centreRotorOffset: 0, rightRotorOffset: 0)
        
        XCTAssert(mainStore.state.rotorState == newRotorState, "Setting reflector has not updated the rotor state")
    }
    
    func testSetRotor() {
        let initialRotorState = RotorState()
        
        XCTAssert(mainStore.state.rotorState == initialRotorState, "The initial rotor state is not the expected default")
        
        mainStore.dispatch(SetRotor(rotor: .left, rotorNumber: 1))
        
        let newRotorState = RotorState(reflectorRow: 1, leftRotorRow: 1, centreRotorRow: 1, rightRotorRow: 2, leftRotorPin: 0, centreRotorPin: 0, rightRotorPin: 0, leftRotorOffset: 0, centreRotorOffset: 0, rightRotorOffset: 0)
        
        XCTAssert(mainStore.state.rotorState == newRotorState, "Setting left rotor has not updated the rotor state")
    }
    
    func testSetPinOffset() {
        let initialRotorState = RotorState()
        
        XCTAssert(mainStore.state.rotorState == initialRotorState, "The initial rotor state is not the expected default")
        
        mainStore.dispatch(SetPinOffset(rotor: .left, pinOffset: 1))
        
        let newRotorState = RotorState(reflectorRow: 1, leftRotorRow: 0, centreRotorRow: 1, rightRotorRow: 2, leftRotorPin: 1, centreRotorPin: 0, rightRotorPin: 0, leftRotorOffset: 0, centreRotorOffset: 0, rightRotorOffset: 0)
        
        XCTAssert(mainStore.state.rotorState == newRotorState, "Setting left rotor pin has not updated the rotor state")
    }
    
    func testSetInitialPosition() {
        let initialRotorState = RotorState()
        
        XCTAssert(mainStore.state.rotorState == initialRotorState, "The initial rotor state is not the expected default")
        
        mainStore.dispatch(SetInitialPosition(rotor: .left, offset: 1))
        
        let newRotorState = RotorState(reflectorRow: 1, leftRotorRow: 0, centreRotorRow: 1, rightRotorRow: 2, leftRotorPin: 0, centreRotorPin: 0, rightRotorPin: 0, leftRotorOffset: 1, centreRotorOffset: 0, rightRotorOffset: 0)
        
        XCTAssert(mainStore.state.rotorState == newRotorState, "Setting left rotor has not updated the rotor state")
    }
    
    // MARK: - Generic tests
    
    func testDefaultBDZGO() {
        // print(mainStore.state)
        let initialRotorState = RotorState()
        
        XCTAssert(mainStore.state.rotorState == initialRotorState, "Initial rotor state is not the expected default")
        
        for _ in 1...5 {
            guard let encodedLetter = Helpers.encode("A") else {
                XCTAssert(false, "'A' could not be encoded")
                return
            }
            
            mainStore.dispatch(SelectLetter(letter: encodedLetter))
        }
        
        let outputAfter = OutputState(currentLetter: "O", message: "BDZGO")
        
        XCTAssert(mainStore.state.outputState == outputAfter, "Output state does not match expected value")
        
        let rotorStateAfter = RotorState(reflectorRow: 1, leftRotorRow: 0, centreRotorRow: 1, rightRotorRow: 2, leftRotorPin: 0, centreRotorPin: 0, rightRotorPin: 0, leftRotorOffset: 0, centreRotorOffset: 0, rightRotorOffset: 5)
        
        XCTAssert(mainStore.state.rotorState == rotorStateAfter, "Selecting letters has not updated the rotor state")
    }
}
