//
//  ReSwift_Enigma_Mock_Tests.swift
//  ReSwift Enigma Mock Tests
//
//  Created by James Coleman on 05/08/2017.
//  Copyright © 2017 James Coleman. All rights reserved.
//

import XCTest
@testable import ReSwift_Enigma

class ReSwift_Enigma_Mock_Tests: XCTestCase {
    
    var mockSetupViewController: SetupViewController!
    var mockCodeViewController: CodeViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        mockSetupViewController = storyboard.instantiateViewController(withIdentifier: Screen.SetupViewController.rawValue) as? SetupViewController
        mockCodeViewController  = storyboard.instantiateViewController(withIdentifier: Screen.CodeViewController.rawValue)  as? CodeViewController
        
        XCTAssertNotNil(mockSetupViewController.view)
        XCTAssertNotNil(mockCodeViewController.view)
        
        mockSetupViewController.viewWillAppear(true) // Using viewWillAppear instead of simply mainStore.subscribe(self) to confirm the execution inside viewWillAppear
        mockCodeViewController.viewWillAppear(true)
        
        mainStore.dispatch(DebugResetState())
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mainStore.dispatch(DebugResetState())
        
        mockSetupViewController.viewWillDisappear(true)
        mockCodeViewController.viewWillDisappear(true)
        
        mockSetupViewController = nil
        mockCodeViewController = nil
        
        super.tearDown()
    }
    
    /*
     func testExample() {
     // This is an example of a functional test case.
     // Use XCTAssert and related functions to verify your tests produce the correct results.
     }
     
     func testPerformanceExample() {
     // This is an example of a performance test case.
     self.measure {
     // Put the code you want to measure the time of here.
     }
     }
     */
    
    // Debug to test subscribing to state
    //    func testSetState() {
    //        print(mainStore.state.rotorState.reflectorRow)
    //        print(mockSetupViewController.reflectorAndRotors.selectedRow(inComponent: 0))
    //        mainStore.dispatch(SetReflector(reflector: 0))
    //        print(mainStore.state.rotorState.reflectorRow)
    //        print(mockSetupViewController.reflectorAndRotors.selectedRow(inComponent: 0))
    //        mainStore.dispatch(SetReflector(reflector: 2))
    //        print(mainStore.state.rotorState.reflectorRow)
    //        print(mockSetupViewController.reflectorAndRotors.selectedRow(inComponent: 0))
    //    }
    
    // MARK: - Initial Existance and Setup
    
    func testOutletsExist() {
        // MARK: Setup View Controller
        XCTAssertNotNil(mockSetupViewController.reflectorAndRotors)
        XCTAssertNotNil(mockSetupViewController.pinOffset)
        XCTAssertNotNil(mockSetupViewController.initialRotorOffset)
        
        XCTAssertNotNil(mockSetupViewController.plugboardQ)
        XCTAssertNotNil(mockSetupViewController.plugboardW)
        XCTAssertNotNil(mockSetupViewController.plugboardE)
        XCTAssertNotNil(mockSetupViewController.plugboardR)
        XCTAssertNotNil(mockSetupViewController.plugboardT)
        XCTAssertNotNil(mockSetupViewController.plugboardZ)
        XCTAssertNotNil(mockSetupViewController.plugboardU)
        XCTAssertNotNil(mockSetupViewController.plugboardI)
        XCTAssertNotNil(mockSetupViewController.plugboardO)
        
        XCTAssertNotNil(mockSetupViewController.plugboardA)
        XCTAssertNotNil(mockSetupViewController.plugboardS)
        XCTAssertNotNil(mockSetupViewController.plugboardD)
        XCTAssertNotNil(mockSetupViewController.plugboardF)
        XCTAssertNotNil(mockSetupViewController.plugboardG)
        XCTAssertNotNil(mockSetupViewController.plugboardH)
        XCTAssertNotNil(mockSetupViewController.plugboardJ)
        XCTAssertNotNil(mockSetupViewController.plugboardK)
        
        XCTAssertNotNil(mockSetupViewController.plugboardP)
        XCTAssertNotNil(mockSetupViewController.plugboardY)
        XCTAssertNotNil(mockSetupViewController.plugboardX)
        XCTAssertNotNil(mockSetupViewController.plugboardC)
        XCTAssertNotNil(mockSetupViewController.plugboardV)
        XCTAssertNotNil(mockSetupViewController.plugboardB)
        XCTAssertNotNil(mockSetupViewController.plugboardN)
        XCTAssertNotNil(mockSetupViewController.plugboardM)
        XCTAssertNotNil(mockSetupViewController.plugboardL)
        
        XCTAssertNotNil(mockSetupViewController.topConstraint)
        XCTAssertNotNil(mockSetupViewController.bottomConstraint)
        
        // MARK: Code View Controller
        XCTAssertNotNil(mockCodeViewController.rotors)
        
        XCTAssertNotNil(mockCodeViewController.messageLabel)
        XCTAssertNotNil(mockCodeViewController.deleteButton)
        
        XCTAssertNotNil(mockCodeViewController.lightQ)
        XCTAssertNotNil(mockCodeViewController.lightW)
        XCTAssertNotNil(mockCodeViewController.lightE)
        XCTAssertNotNil(mockCodeViewController.lightR)
        XCTAssertNotNil(mockCodeViewController.lightT)
        XCTAssertNotNil(mockCodeViewController.lightZ)
        XCTAssertNotNil(mockCodeViewController.lightU)
        XCTAssertNotNil(mockCodeViewController.lightI)
        XCTAssertNotNil(mockCodeViewController.lightO)
        
        XCTAssertNotNil(mockCodeViewController.lightA)
        XCTAssertNotNil(mockCodeViewController.lightS)
        XCTAssertNotNil(mockCodeViewController.lightD)
        XCTAssertNotNil(mockCodeViewController.lightF)
        XCTAssertNotNil(mockCodeViewController.lightG)
        XCTAssertNotNil(mockCodeViewController.lightH)
        XCTAssertNotNil(mockCodeViewController.lightJ)
        XCTAssertNotNil(mockCodeViewController.lightK)
        
        XCTAssertNotNil(mockCodeViewController.lightP)
        XCTAssertNotNil(mockCodeViewController.lightY)
        XCTAssertNotNil(mockCodeViewController.lightX)
        XCTAssertNotNil(mockCodeViewController.lightC)
        XCTAssertNotNil(mockCodeViewController.lightV)
        XCTAssertNotNil(mockCodeViewController.lightB)
        XCTAssertNotNil(mockCodeViewController.lightN)
        XCTAssertNotNil(mockCodeViewController.lightM)
        XCTAssertNotNil(mockCodeViewController.lightL)
        
        XCTAssertNotNil(mockCodeViewController.keyQ)
        XCTAssertNotNil(mockCodeViewController.keyW)
        XCTAssertNotNil(mockCodeViewController.keyE)
        XCTAssertNotNil(mockCodeViewController.keyR)
        XCTAssertNotNil(mockCodeViewController.keyT)
        XCTAssertNotNil(mockCodeViewController.keyZ)
        XCTAssertNotNil(mockCodeViewController.keyU)
        XCTAssertNotNil(mockCodeViewController.keyI)
        XCTAssertNotNil(mockCodeViewController.keyO)
        
        XCTAssertNotNil(mockCodeViewController.keyA)
        XCTAssertNotNil(mockCodeViewController.keyS)
        XCTAssertNotNil(mockCodeViewController.keyD)
        XCTAssertNotNil(mockCodeViewController.keyF)
        XCTAssertNotNil(mockCodeViewController.keyG)
        XCTAssertNotNil(mockCodeViewController.keyH)
        XCTAssertNotNil(mockCodeViewController.keyJ)
        XCTAssertNotNil(mockCodeViewController.keyK)
        
        XCTAssertNotNil(mockCodeViewController.keyP)
        XCTAssertNotNil(mockCodeViewController.keyY)
        XCTAssertNotNil(mockCodeViewController.keyX)
        XCTAssertNotNil(mockCodeViewController.keyC)
        XCTAssertNotNil(mockCodeViewController.keyV)
        XCTAssertNotNil(mockCodeViewController.keyB)
        XCTAssertNotNil(mockCodeViewController.keyN)
        XCTAssertNotNil(mockCodeViewController.keyM)
        XCTAssertNotNil(mockCodeViewController.keyL)
    }
    
    func testInitialSetupState() {
        let rotorState = mainStore.state.rotorState
        
        // Reflector and Rotors
        
        let reflectorAndRotors = mockSetupViewController.reflectorAndRotors!
        
        let defaultReflector = rotorState.reflectorRow
        let displayedReflector = reflectorAndRotors.selectedRow(inComponent: 0)
        
        XCTAssert(defaultReflector == displayedReflector)
        
        let defaultLeftRotor = rotorState.leftRotorRow
        let displayedLeftRotor = reflectorAndRotors.selectedRow(inComponent: 1)
        
        XCTAssert(defaultLeftRotor == displayedLeftRotor)
        
        let defaultCentreRotor = rotorState.centreRotorRow
        let displayedCentreRotor = reflectorAndRotors.selectedRow(inComponent: 2)
        
        XCTAssert(defaultCentreRotor == displayedCentreRotor)
        
        let defaultRightRotor = rotorState.rightRotorRow
        let displayedRightRotor = reflectorAndRotors.selectedRow(inComponent: 3)
        
        XCTAssert(defaultRightRotor == displayedRightRotor)
        
        // Pin Offset
        
        let pinOffset = mockSetupViewController.pinOffset!
        
        let defaultLeftRotorPin = rotorState.leftRotorPin
        let displayedLeftRotorPin = pinOffset.selectedRow(inComponent: 0)
        
        XCTAssert(defaultLeftRotorPin == displayedLeftRotorPin)
        
        let defaultCentreRotorPin = rotorState.centreRotorPin
        let displayedCentreRotorPin = pinOffset.selectedRow(inComponent: 1)
        
        XCTAssert(defaultCentreRotorPin == displayedCentreRotorPin)
        
        let defaultRightRotorPin = rotorState.rightRotorPin
        let displayedRightRotorPin = pinOffset.selectedRow(inComponent: 2)
        
        XCTAssert(defaultRightRotorPin == displayedRightRotorPin)
        
        // Initial Rotor Offset
        
        let initialRotorOffset = mockSetupViewController.initialRotorOffset!
        
        let defaultLeftRotorOffset = rotorState.leftRotorOffset
        let displayeLeftRotorOffset = initialRotorOffset.selectedRow(inComponent: 0)
        
        XCTAssert(defaultLeftRotorOffset == displayeLeftRotorOffset)
        
        let defaultCentreRotorOffset = rotorState.centreRotorOffset
        let displayeCentreRotorOffset = initialRotorOffset.selectedRow(inComponent: 1)
        
        XCTAssert(defaultCentreRotorOffset == displayeCentreRotorOffset)
        
        let defaultRightRotorOffset = rotorState.rightRotorOffset
        let displayeRightRotorOffset = initialRotorOffset.selectedRow(inComponent: 2)
        
        XCTAssert(defaultRightRotorOffset == displayeRightRotorOffset)
        
        // Plugboard
        
        let plugboardState = mainStore.state.plugboardState.plugboard
        
        XCTAssert(mockSetupViewController.plugboardA.text == plugboardState["A"])
        XCTAssert(mockSetupViewController.plugboardB.text == plugboardState["B"])
        XCTAssert(mockSetupViewController.plugboardC.text == plugboardState["C"])
        XCTAssert(mockSetupViewController.plugboardD.text == plugboardState["D"])
        XCTAssert(mockSetupViewController.plugboardE.text == plugboardState["E"])
        XCTAssert(mockSetupViewController.plugboardF.text == plugboardState["F"])
        XCTAssert(mockSetupViewController.plugboardG.text == plugboardState["G"])
        XCTAssert(mockSetupViewController.plugboardH.text == plugboardState["H"])
        XCTAssert(mockSetupViewController.plugboardI.text == plugboardState["I"])
        XCTAssert(mockSetupViewController.plugboardJ.text == plugboardState["J"])
        XCTAssert(mockSetupViewController.plugboardK.text == plugboardState["K"])
        XCTAssert(mockSetupViewController.plugboardL.text == plugboardState["L"])
        XCTAssert(mockSetupViewController.plugboardM.text == plugboardState["M"])
        XCTAssert(mockSetupViewController.plugboardN.text == plugboardState["N"])
        XCTAssert(mockSetupViewController.plugboardO.text == plugboardState["O"])
        XCTAssert(mockSetupViewController.plugboardP.text == plugboardState["P"])
        XCTAssert(mockSetupViewController.plugboardQ.text == plugboardState["Q"])
        XCTAssert(mockSetupViewController.plugboardR.text == plugboardState["R"])
        XCTAssert(mockSetupViewController.plugboardS.text == plugboardState["S"])
        XCTAssert(mockSetupViewController.plugboardT.text == plugboardState["T"])
        XCTAssert(mockSetupViewController.plugboardU.text == plugboardState["U"])
        XCTAssert(mockSetupViewController.plugboardV.text == plugboardState["V"])
        XCTAssert(mockSetupViewController.plugboardW.text == plugboardState["W"])
        XCTAssert(mockSetupViewController.plugboardX.text == plugboardState["X"])
        XCTAssert(mockSetupViewController.plugboardY.text == plugboardState["Y"])
        XCTAssert(mockSetupViewController.plugboardZ.text == plugboardState["Z"])
    }
    
    func testSetupDelegates() {
        
        // Delegates not nil
        
        guard let reflectorsAndRotorsDelegate   = mockSetupViewController.reflectorAndRotors.delegate else { XCTFail(); return }
        guard let pinOffsetDelegate             = mockSetupViewController.pinOffset         .delegate else { XCTFail(); return }
        guard let initialOffsetDelegate         = mockSetupViewController.initialRotorOffset.delegate else { XCTFail(); return }
        
        guard let plugboardQDelegate = mockSetupViewController.plugboardQ.delegate else { XCTFail(); return }
        guard let plugboardWDelegate = mockSetupViewController.plugboardW.delegate else { XCTFail(); return }
        guard let plugboardEDelegate = mockSetupViewController.plugboardE.delegate else { XCTFail(); return }
        guard let plugboardRDelegate = mockSetupViewController.plugboardR.delegate else { XCTFail(); return }
        guard let plugboardTDelegate = mockSetupViewController.plugboardT.delegate else { XCTFail(); return }
        guard let plugboardZDelegate = mockSetupViewController.plugboardZ.delegate else { XCTFail(); return }
        guard let plugboardUDelegate = mockSetupViewController.plugboardU.delegate else { XCTFail(); return }
        guard let plugboardIDelegate = mockSetupViewController.plugboardI.delegate else { XCTFail(); return }
        guard let plugboardODelegate = mockSetupViewController.plugboardO.delegate else { XCTFail(); return }
        
        guard let plugboardADelegate = mockSetupViewController.plugboardA.delegate else { XCTFail(); return }
        guard let plugboardSDelegate = mockSetupViewController.plugboardS.delegate else { XCTFail(); return }
        guard let plugboardDDelegate = mockSetupViewController.plugboardD.delegate else { XCTFail(); return }
        guard let plugboardFDelegate = mockSetupViewController.plugboardF.delegate else { XCTFail(); return }
        guard let plugboardGDelegate = mockSetupViewController.plugboardG.delegate else { XCTFail(); return }
        guard let plugboardHDelegate = mockSetupViewController.plugboardH.delegate else { XCTFail(); return }
        guard let plugboardJDelegate = mockSetupViewController.plugboardJ.delegate else { XCTFail(); return }
        guard let plugboardKDelegate = mockSetupViewController.plugboardK.delegate else { XCTFail(); return }
        
        guard let plugboardPDelegate = mockSetupViewController.plugboardP.delegate else { XCTFail(); return }
        guard let plugboardYDelegate = mockSetupViewController.plugboardY.delegate else { XCTFail(); return }
        guard let plugboardXDelegate = mockSetupViewController.plugboardX.delegate else { XCTFail(); return }
        guard let plugboardCDelegate = mockSetupViewController.plugboardC.delegate else { XCTFail(); return }
        guard let plugboardVDelegate = mockSetupViewController.plugboardV.delegate else { XCTFail(); return }
        guard let plugboardBDelegate = mockSetupViewController.plugboardB.delegate else { XCTFail(); return }
        guard let plugboardNDelegate = mockSetupViewController.plugboardN.delegate else { XCTFail(); return }
        guard let plugboardMDelegate = mockSetupViewController.plugboardM.delegate else { XCTFail(); return }
        guard let plugboardLDelegate = mockSetupViewController.plugboardL.delegate else { XCTFail(); return }
        
        // Same hash
        
        let mockSetupViewControllerHash = mockSetupViewController.hash
        
        XCTAssert(reflectorsAndRotorsDelegate   .hash == mockSetupViewControllerHash)
        XCTAssert(pinOffsetDelegate             .hash == mockSetupViewControllerHash)
        XCTAssert(initialOffsetDelegate         .hash == mockSetupViewControllerHash)
        
        XCTAssert(plugboardQDelegate.hash == mockSetupViewControllerHash)
        XCTAssert(plugboardWDelegate.hash == mockSetupViewControllerHash)
        XCTAssert(plugboardEDelegate.hash == mockSetupViewControllerHash)
        XCTAssert(plugboardRDelegate.hash == mockSetupViewControllerHash)
        XCTAssert(plugboardTDelegate.hash == mockSetupViewControllerHash)
        XCTAssert(plugboardZDelegate.hash == mockSetupViewControllerHash)
        XCTAssert(plugboardUDelegate.hash == mockSetupViewControllerHash)
        XCTAssert(plugboardIDelegate.hash == mockSetupViewControllerHash)
        XCTAssert(plugboardODelegate.hash == mockSetupViewControllerHash)
        
        XCTAssert(plugboardADelegate.hash == mockSetupViewControllerHash)
        XCTAssert(plugboardSDelegate.hash == mockSetupViewControllerHash)
        XCTAssert(plugboardDDelegate.hash == mockSetupViewControllerHash)
        XCTAssert(plugboardFDelegate.hash == mockSetupViewControllerHash)
        XCTAssert(plugboardGDelegate.hash == mockSetupViewControllerHash)
        XCTAssert(plugboardHDelegate.hash == mockSetupViewControllerHash)
        XCTAssert(plugboardJDelegate.hash == mockSetupViewControllerHash)
        XCTAssert(plugboardKDelegate.hash == mockSetupViewControllerHash)
        
        XCTAssert(plugboardPDelegate.hash == mockSetupViewControllerHash)
        XCTAssert(plugboardYDelegate.hash == mockSetupViewControllerHash)
        XCTAssert(plugboardXDelegate.hash == mockSetupViewControllerHash)
        XCTAssert(plugboardCDelegate.hash == mockSetupViewControllerHash)
        XCTAssert(plugboardVDelegate.hash == mockSetupViewControllerHash)
        XCTAssert(plugboardBDelegate.hash == mockSetupViewControllerHash)
        XCTAssert(plugboardNDelegate.hash == mockSetupViewControllerHash)
        XCTAssert(plugboardMDelegate.hash == mockSetupViewControllerHash)
        XCTAssert(plugboardLDelegate.hash == mockSetupViewControllerHash)
        
        // Same description
        
        let mockSetupViewControllerDescription = mockSetupViewController.description
        
        XCTAssert(reflectorsAndRotorsDelegate   .description == mockSetupViewControllerDescription)
        XCTAssert(pinOffsetDelegate             .description == mockSetupViewControllerDescription)
        XCTAssert(initialOffsetDelegate         .description == mockSetupViewControllerDescription)
        
        XCTAssert(plugboardQDelegate.description == mockSetupViewControllerDescription)
        XCTAssert(plugboardWDelegate.description == mockSetupViewControllerDescription)
        XCTAssert(plugboardEDelegate.description == mockSetupViewControllerDescription)
        XCTAssert(plugboardRDelegate.description == mockSetupViewControllerDescription)
        XCTAssert(plugboardTDelegate.description == mockSetupViewControllerDescription)
        XCTAssert(plugboardZDelegate.description == mockSetupViewControllerDescription)
        XCTAssert(plugboardUDelegate.description == mockSetupViewControllerDescription)
        XCTAssert(plugboardIDelegate.description == mockSetupViewControllerDescription)
        XCTAssert(plugboardODelegate.description == mockSetupViewControllerDescription)
        
        XCTAssert(plugboardADelegate.description == mockSetupViewControllerDescription)
        XCTAssert(plugboardSDelegate.description == mockSetupViewControllerDescription)
        XCTAssert(plugboardDDelegate.description == mockSetupViewControllerDescription)
        XCTAssert(plugboardFDelegate.description == mockSetupViewControllerDescription)
        XCTAssert(plugboardGDelegate.description == mockSetupViewControllerDescription)
        XCTAssert(plugboardGDelegate.description == mockSetupViewControllerDescription)
        XCTAssert(plugboardHDelegate.description == mockSetupViewControllerDescription)
        XCTAssert(plugboardJDelegate.description == mockSetupViewControllerDescription)
        XCTAssert(plugboardKDelegate.description == mockSetupViewControllerDescription)
        
        XCTAssert(plugboardPDelegate.description == mockSetupViewControllerDescription)
        XCTAssert(plugboardYDelegate.description == mockSetupViewControllerDescription)
        XCTAssert(plugboardXDelegate.description == mockSetupViewControllerDescription)
        XCTAssert(plugboardCDelegate.description == mockSetupViewControllerDescription)
        XCTAssert(plugboardVDelegate.description == mockSetupViewControllerDescription)
        XCTAssert(plugboardBDelegate.description == mockSetupViewControllerDescription)
        XCTAssert(plugboardNDelegate.description == mockSetupViewControllerDescription)
        XCTAssert(plugboardMDelegate.description == mockSetupViewControllerDescription)
        XCTAssert(plugboardLDelegate.description == mockSetupViewControllerDescription)
        
    }
    
    func testInitialCodeState() {
        // Rotors
        
        let rotorState = mainStore.state.rotorState
        
        guard let rotors = mockCodeViewController.rotors else { XCTFail(); return }
        
        // Left Rotor
        
        let leftRotorRow = 0
        let defaultLeftRotorRow = rotorState.leftRotorOffset
        let displayedLeftRotor = rotors.selectedRow(inComponent: leftRotorRow)
        XCTAssert(defaultLeftRotorRow == displayedLeftRotor)
        
        // Centre Rotor
        
        let centreRotorRow = 1
        let defaultCentreRotorRow = rotorState.centreRotorOffset
        let displayedCentreRotor = rotors.selectedRow(inComponent: centreRotorRow)
        XCTAssert(defaultCentreRotorRow == displayedCentreRotor)
        
        // Right Rotor
        
        let rightRotorRow = 2
        let defaultRightRotorRow = rotorState.rightRotorOffset
        let displayedRightRotor = rotors.selectedRow(inComponent: rightRotorRow)
        XCTAssert(defaultRightRotorRow == displayedRightRotor)
        
        // Lights
        
        XCTAssert(mockCodeViewController.lights.count == Data.alphabetCount)
        
        let _ = mockCodeViewController.lights.map() { (letter, label) in
            XCTAssert(label.textColor == .lightGray)
        }
        
        // Message
        
        let outputState = mainStore.state.outputState
        
        XCTAssert(mockCodeViewController.messageLabel.text == outputState.message)
    }
    
    func testCodeDelegates() {
        guard let rotorsDelegate = mockCodeViewController.rotors.delegate else { XCTFail(); return }
        
        let mockCodeViewControllerHash = mockCodeViewController.hash
        
        XCTAssert(rotorsDelegate.hash == mockCodeViewControllerHash)
        
        let mockCodeViewControllerDescription = mockCodeViewController.description
        
        XCTAssert(rotorsDelegate.description == mockCodeViewControllerDescription)
    }
    
    // MARK: - Rotor Actions
    
    func testSetReflector() {
        let rotorState = mainStore.state.rotorState
        
        guard let reflectorAndRotors = mockSetupViewController.reflectorAndRotors else { XCTFail(); return }
        
        let reflectorRow = 0
        
        let defaultReflector = rotorState.reflectorRow
        let displayedReflector = reflectorAndRotors.selectedRow(inComponent: reflectorRow)
        XCTAssert(defaultReflector == displayedReflector)
        
        let reflector0 = 0
        let action0 = SetReflector(reflector: reflector0)
        mainStore.dispatch(action0)
        let secondDisplayedReflector = reflectorAndRotors.selectedRow(inComponent: reflectorRow)
        XCTAssert(secondDisplayedReflector == reflector0)
        
        let reflector1 = 1
        let action1 = SetReflector(reflector: reflector1)
        mainStore.dispatch(action1)
        let thirdDisplayedReflector = reflectorAndRotors.selectedRow(inComponent: reflectorRow)
        XCTAssert(thirdDisplayedReflector == reflector1)
        
        let reflector2 = 2
        let action2 = SetReflector(reflector: reflector2)
        mainStore.dispatch(action2)
        let fourthDisplayedReflector = reflectorAndRotors.selectedRow(inComponent: reflectorRow)
        XCTAssert(fourthDisplayedReflector == reflector2)
    }
    
    // Like initial setup, test all (left, centre, right) in one test, to have one test per action?
    func testSetRotor() {
        let rotorState = mainStore.state.rotorState
        
        let reflectorAndRotors = mockSetupViewController.reflectorAndRotors!
        
        let rotorI = 0
        let rotorII = 1
        let rotorIII = 2
        
        // Left Rotor
        
        let leftRotorRow = 1
        
        let defaultLeftRotorRow = rotorState.leftRotorRow
        let displayedLeftRotor = reflectorAndRotors.selectedRow(inComponent: leftRotorRow)
        XCTAssert(defaultLeftRotorRow == displayedLeftRotor)
        
        let actionLeftI = SetRotor(rotor: .left, rotorNumber: rotorI)
        mainStore.dispatch(actionLeftI)
        let displayedLeftRotorI = reflectorAndRotors.selectedRow(inComponent: leftRotorRow)
        XCTAssert(displayedLeftRotorI == rotorI)
        
        let actionLeftII = SetRotor(rotor: .left, rotorNumber: rotorII)
        mainStore.dispatch(actionLeftII)
        let displayedLeftRotorII = reflectorAndRotors.selectedRow(inComponent: leftRotorRow)
        XCTAssert(displayedLeftRotorII == rotorII)
        
        let actionLeftIII = SetRotor(rotor: .left, rotorNumber: rotorIII)
        mainStore.dispatch(actionLeftIII)
        let displayedLeftRotorIII = reflectorAndRotors.selectedRow(inComponent: leftRotorRow)
        XCTAssert(displayedLeftRotorIII == rotorIII)
        
        // Centre Rotor
        
        let centreRotorRow = 2
        
        let defaultCentreRotorRow = rotorState.centreRotorRow
        let displayedCentreRotor = reflectorAndRotors.selectedRow(inComponent: centreRotorRow)
        XCTAssert(defaultCentreRotorRow == displayedCentreRotor)
        
        let actionCentreI = SetRotor(rotor: .centre, rotorNumber: rotorI)
        mainStore.dispatch(actionCentreI)
        let displayedCentreRotorI = reflectorAndRotors.selectedRow(inComponent: centreRotorRow)
        XCTAssert(displayedCentreRotorI == rotorI)
        
        let actionCentreII = SetRotor(rotor: .centre, rotorNumber: rotorII)
        mainStore.dispatch(actionCentreII)
        let displayedCentreRotorII = reflectorAndRotors.selectedRow(inComponent: centreRotorRow)
        XCTAssert(displayedCentreRotorII == rotorII)
        
        let actionCentreIII = SetRotor(rotor: .centre, rotorNumber: rotorIII)
        mainStore.dispatch(actionCentreIII)
        let displayedCentreRotorIII = reflectorAndRotors.selectedRow(inComponent: centreRotorRow)
        XCTAssert(displayedCentreRotorIII == rotorIII)
        
        // Right Rotor
        
        let rightRotorRow = 3
        
        let defaultRightRotorRow = rotorState.rightRotorRow
        let displayedRightRotor = reflectorAndRotors.selectedRow(inComponent: rightRotorRow)
        XCTAssert(defaultRightRotorRow == displayedRightRotor)
        
        let actionRightI = SetRotor(rotor: .right, rotorNumber: rotorI)
        mainStore.dispatch(actionRightI)
        let displayedRightRotorI = reflectorAndRotors.selectedRow(inComponent: rightRotorRow)
        XCTAssert(displayedRightRotorI == rotorI)
        
        let actionRightII = SetRotor(rotor: .right, rotorNumber: rotorII)
        mainStore.dispatch(actionRightII)
        let displayedRightRotorII = reflectorAndRotors.selectedRow(inComponent: rightRotorRow)
        XCTAssert(displayedRightRotorII == rotorII)
        
        let actionRightIII = SetRotor(rotor: .right, rotorNumber: rotorIII)
        mainStore.dispatch(actionRightIII)
        let displayedRightRotorIII = reflectorAndRotors.selectedRow(inComponent: rightRotorRow)
        XCTAssert(displayedRightRotorIII == rotorIII)
    }
    
    func testSetPinOffset() {
        let rotorState = mainStore.state.rotorState
        
        let pinOffset = mockSetupViewController.pinOffset!
        
        // Left Pin
        
        let leftPinRow = 0
        
        let defaultLeftPinRow = rotorState.leftRotorPin
        let displayedLeftPin = pinOffset.selectedRow(inComponent: leftPinRow)
        XCTAssert(defaultLeftPinRow == displayedLeftPin)
        
        for i in 0..<Data.alphabetCount {
            let action = SetPinOffset(rotor: .left, pinOffset: i)
            mainStore.dispatch(action)
            let displayedLeftPinLoop = pinOffset.selectedRow(inComponent: leftPinRow)
            XCTAssert(displayedLeftPinLoop == i)
        }
        
        // Centre Pin
        
        let centrePinRow = 1
        
        let defaultCentrePinRow = rotorState.leftRotorPin
        let displayedCentrePin = pinOffset.selectedRow(inComponent: centrePinRow)
        XCTAssert(defaultCentrePinRow == displayedCentrePin)
        
        for i in 0..<Data.alphabetCount {
            let action = SetPinOffset(rotor: .centre, pinOffset: i)
            mainStore.dispatch(action)
            let displayedCentrePinLoop = pinOffset.selectedRow(inComponent: centrePinRow)
            XCTAssert(displayedCentrePinLoop == i)
        }
        
        // Right Pin
        
        let rightPinRow = 2
        
        let defaultRightPinRow = rotorState.leftRotorPin
        let displayedRightPin = pinOffset.selectedRow(inComponent: rightPinRow)
        XCTAssert(defaultRightPinRow == displayedRightPin)
        
        for i in 0..<Data.alphabetCount {
            let action = SetPinOffset(rotor: .right, pinOffset: i)
            mainStore.dispatch(action)
            let displayedRightPinLoop = pinOffset.selectedRow(inComponent: rightPinRow)
            XCTAssert(displayedRightPinLoop == i)
        }
    }
    
    func testSetInitialPosition() {
        let rotorState = mainStore.state.rotorState
        
        guard let setupRotorOffset = mockSetupViewController.initialRotorOffset else { XCTFail(); return }
        guard let codeRotorOffset = mockCodeViewController.rotors else { XCTFail(); return }
        
        // Left Rotor
        
        let leftRotorRow = 0
        
        let defaultLeftRotorPosition = rotorState.leftRotorOffset
        
        let displayedSetupLeftRotorPosition = setupRotorOffset.selectedRow(inComponent: leftRotorRow)
        XCTAssert(defaultLeftRotorPosition == displayedSetupLeftRotorPosition)
        
        let displayedCodeLeftRotorPosition = codeRotorOffset.selectedRow(inComponent: leftRotorRow)
        XCTAssert(defaultLeftRotorPosition == displayedCodeLeftRotorPosition)
        
        for i in 0..<Data.alphabetCount {
            let action = SetInitialPosition(rotor: .left, offset: i)
            mainStore.dispatch(action)
            
            let displayedSetupLeftRotorPositionLoop = setupRotorOffset.selectedRow(inComponent: leftRotorRow)
            XCTAssert(displayedSetupLeftRotorPositionLoop == i)
            
            let displayedCodeLeftRotorPositionLoop = codeRotorOffset.selectedRow(inComponent: leftRotorRow)
            XCTAssert(displayedCodeLeftRotorPositionLoop == i)
        }
        
        // Centre Rotor
        
        let centreRotorRow = 1
        
        let defaultCentreRotorPosition = rotorState.leftRotorOffset
        
        let displayedSetupCentreRotorPosition = setupRotorOffset.selectedRow(inComponent: centreRotorRow)
        XCTAssert(defaultCentreRotorPosition == displayedSetupCentreRotorPosition)
        
        let displayedCodeCentreRotorPosition = codeRotorOffset.selectedRow(inComponent: centreRotorRow)
        XCTAssert(defaultCentreRotorPosition == displayedCodeCentreRotorPosition)
        
        for i in 0..<Data.alphabetCount {
            let action = SetInitialPosition(rotor: .centre, offset: i)
            mainStore.dispatch(action)
            
            let displayedSetupCentreRotorPositionLoop = setupRotorOffset.selectedRow(inComponent: centreRotorRow)
            XCTAssert(displayedSetupCentreRotorPositionLoop == i)
            
            let displayedCodeCentreRotorPositionLoop = codeRotorOffset.selectedRow(inComponent: centreRotorRow)
            XCTAssert(displayedCodeCentreRotorPositionLoop == i)
        }
        
        // Right Rotor
        
        let rightRotorRow = 2
        
        let defaultRightRotorPosition = rotorState.leftRotorOffset
        
        let displayedSetupRightRotorPosition = setupRotorOffset.selectedRow(inComponent: rightRotorRow)
        XCTAssert(defaultRightRotorPosition == displayedSetupRightRotorPosition)
        
        let displayedCodeRightRotorPosition = codeRotorOffset.selectedRow(inComponent: rightRotorRow)
        XCTAssert(defaultRightRotorPosition == displayedCodeRightRotorPosition)
        
        for i in 0..<Data.alphabetCount {
            let action = SetInitialPosition(rotor: .right, offset: i)
            mainStore.dispatch(action)
            
            let displayedSetupRightRotorPositionLoop = setupRotorOffset.selectedRow(inComponent: rightRotorRow)
            XCTAssert(displayedSetupRightRotorPositionLoop == i)
            
            let displayedCodeRightRotorPositionLoop = codeRotorOffset.selectedRow(inComponent: rightRotorRow)
            XCTAssert(displayedCodeRightRotorPositionLoop == i)
        }
    }
    
    // MARK: View
    
    func testPickReflector() {
        var rotorState: RotorState {
            return mainStore.state.rotorState
        }
        
        guard let reflectorAndRotors = mockSetupViewController.reflectorAndRotors else { XCTFail(); return }
        
        let reflectorRow = 0
        
        let defaultReflector = rotorState.reflectorRow
        let displayedReflector = reflectorAndRotors.selectedRow(inComponent: reflectorRow)
        XCTAssert(defaultReflector == displayedReflector)
        
        let reflectorA = 0
        
        reflectorAndRotors.selectRow(reflectorA, inComponent: reflectorRow, animated: false)
        mockSetupViewController.pickerView(reflectorAndRotors, didSelectRow: reflectorA, inComponent: reflectorRow)
        let firstStateReflector = rotorState.reflectorRow
        XCTAssert(firstStateReflector == reflectorA)
        
        let reflectorB = 1
        
        reflectorAndRotors.selectRow(reflectorB, inComponent: reflectorRow, animated: false)
        mockSetupViewController.pickerView(reflectorAndRotors, didSelectRow: reflectorB, inComponent: reflectorRow)
        let secondStateReflector = rotorState.reflectorRow
        XCTAssert(secondStateReflector == reflectorB)
        
        let reflectorC = 2
        
        reflectorAndRotors.selectRow(reflectorC, inComponent: reflectorRow, animated: false)
        mockSetupViewController.pickerView(reflectorAndRotors, didSelectRow: reflectorC, inComponent: reflectorRow)
        let thirdStateReflector = rotorState.reflectorRow
        XCTAssert(thirdStateReflector == reflectorC)
        
    }
    
    func testPickRotor() {
        var rotorState: RotorState {
            return mainStore.state.rotorState
        }
        
        guard let reflectorAndRotors = mockSetupViewController.reflectorAndRotors else { XCTFail(); return }
        
        let rotorRange = [Int](0...2)
        
        // Left Rotor
        
        let leftRotorRow = 1
        
        let defaultLeftRotor = rotorState.leftRotorRow
        let displayedLeftRotor = reflectorAndRotors.selectedRow(inComponent: leftRotorRow)
        XCTAssert(defaultLeftRotor == displayedLeftRotor)
        
        for i in rotorRange {
            reflectorAndRotors.selectRow(i, inComponent: leftRotorRow, animated: false)
            mockSetupViewController.pickerView(reflectorAndRotors, didSelectRow: i, inComponent: leftRotorRow)
            let stateLeftRotorRow = rotorState.leftRotorRow
            XCTAssert(stateLeftRotorRow == i)
        }
        
        // Centre Rotor
        
        let centreRotorRow = 2
        
        let defaultCentreRotor = rotorState.centreRotorRow
        let displayedCentreRotor = reflectorAndRotors.selectedRow(inComponent: centreRotorRow)
        XCTAssert(defaultCentreRotor == displayedCentreRotor)
        
        for i in rotorRange {
            reflectorAndRotors.selectRow(i, inComponent: centreRotorRow, animated: false)
            mockSetupViewController.pickerView(reflectorAndRotors, didSelectRow: i, inComponent: centreRotorRow)
            let stateCentreRotorRow = rotorState.centreRotorRow
            XCTAssert(stateCentreRotorRow == i)
        }
        
        // Right Rotor
        
        let rightRotorRow = 3
        
        let defaultRightRotor = rotorState.rightRotorRow
        let displayedRightRotor = reflectorAndRotors.selectedRow(inComponent: rightRotorRow)
        XCTAssert(defaultRightRotor == displayedRightRotor)
        
        for i in rotorRange {
            reflectorAndRotors.selectRow(i, inComponent: rightRotorRow, animated: false)
            mockSetupViewController.pickerView(reflectorAndRotors, didSelectRow: i, inComponent: rightRotorRow)
            let stateRightRotorRow = rotorState.rightRotorRow
            XCTAssert(stateRightRotorRow == i)
        }
    }
    
    func testPickPinOffset() {
        var rotorState: RotorState {
            return mainStore.state.rotorState
        }
        
        guard let pinOffset = mockSetupViewController.pinOffset else { XCTFail(); return }
        
        // Left Pin
        
        let leftPinComponent = 0
        
        let defaultLeftPinRow = rotorState.leftRotorPin
        let displayedLeftPin = pinOffset.selectedRow(inComponent: leftPinComponent)
        XCTAssert(defaultLeftPinRow == displayedLeftPin)
        
        for i in 0..<Data.alphabetCount {
            pinOffset.selectRow(i, inComponent: leftPinComponent, animated: false)
            mockSetupViewController.pickerView(pinOffset, didSelectRow: i, inComponent: leftPinComponent)
            let stateLeftPinOffset = rotorState.leftRotorPin
            XCTAssert(stateLeftPinOffset == i)
        }
        
        // Centre Pin
        
        let centrePinComponent = 1
        
        let defaultCentrePinRow = rotorState.centreRotorPin
        let displayedCentrePin = pinOffset.selectedRow(inComponent: centrePinComponent)
        XCTAssert(defaultCentrePinRow == displayedCentrePin)
        
        for i in 0..<Data.alphabetCount {
            pinOffset.selectRow(i, inComponent: centrePinComponent, animated: false)
            mockSetupViewController.pickerView(pinOffset, didSelectRow: i, inComponent: centrePinComponent)
            let stateCentrePinOffset = rotorState.centreRotorPin
            XCTAssert(stateCentrePinOffset == i)
        }
        
        // Right Pin
        
        let rightPinComponent = 2
        
        let defaultRightPinRow = rotorState.rightRotorPin
        let displayedRightPin = pinOffset.selectedRow(inComponent: rightPinComponent)
        XCTAssert(defaultRightPinRow == displayedRightPin)
        
        for i in 0..<Data.alphabetCount {
            pinOffset.selectRow(i, inComponent: rightPinComponent, animated: false)
            mockSetupViewController.pickerView(pinOffset, didSelectRow: i, inComponent: rightPinComponent)
            let stateRightPinOffset = rotorState.rightRotorPin
            XCTAssert(stateRightPinOffset == i)
        }
    }
    
    func testPickInitialPosition() {
        var rotorState: RotorState {
            return mainStore.state.rotorState
        }
        
        guard let initialOffset = mockSetupViewController.initialRotorOffset else { XCTFail(); return }
        
        // Left Rotor
        
        let leftRotorComponent = 0
        
        let defaultLeftRotorOffset = rotorState.leftRotorOffset
        let displayedLeftOffset = initialOffset.selectedRow(inComponent: leftRotorComponent)
        XCTAssert(defaultLeftRotorOffset == displayedLeftOffset)
        
        for i in 0..<Data.alphabetCount {
            initialOffset.selectRow(i, inComponent: leftRotorComponent, animated: false)
            mockSetupViewController.pickerView(initialOffset, didSelectRow: i, inComponent: leftRotorComponent)
            let stateLeftOffset = rotorState.leftRotorOffset
            XCTAssert(stateLeftOffset == i)
        }
        
        // Centre Rotor
        
        let centreRotorComponent = 1
        
        let defaultCentreRotorOffset = rotorState.centreRotorOffset
        let displayedCentreOffset = initialOffset.selectedRow(inComponent: centreRotorComponent)
        XCTAssert(defaultCentreRotorOffset == displayedCentreOffset)
        
        for i in 0..<Data.alphabetCount {
            initialOffset.selectRow(i, inComponent: centreRotorComponent, animated: false)
            mockSetupViewController.pickerView(initialOffset, didSelectRow: i, inComponent: centreRotorComponent)
            let stateCentreOffset = rotorState.centreRotorOffset
            XCTAssert(stateCentreOffset == i)
        }
        
        // Right Rotor
        
        let rightRotorComponent = 2
        
        let defaultRightRotorOffset = rotorState.rightRotorOffset
        let displayedRightOffset = initialOffset.selectedRow(inComponent: rightRotorComponent)
        XCTAssert(defaultRightRotorOffset == displayedRightOffset)
        
        for i in 0..<Data.alphabetCount {
            initialOffset.selectRow(i, inComponent: rightRotorComponent, animated: false)
            mockSetupViewController.pickerView(initialOffset, didSelectRow: i, inComponent: rightRotorComponent)
            let stateRightOffset = rotorState.rightRotorOffset
            XCTAssert(stateRightOffset == i)
        }
    }
    
    // MARK: - Plugboard Actions
    
    func reversedPlugboardLetters() -> [String:UITextField] {
        guard let plugboardLetters = mockSetupViewController.plugboardLetters else { XCTFail(); return [:] }
        
        let lettersPlugboard = plugboardLetters.map({ plugboard, letter in
            return [letter:plugboard]
        })
        
        let lettersPlugboardReduced = lettersPlugboard.reduce([:]) { dictionarySoFar, nextKeyValuePair -> [String:UITextField] in
            guard let first = nextKeyValuePair.first else { return [:] }
            var varDictionarySoFar = dictionarySoFar
            varDictionarySoFar[first.key] = first.value
            return varDictionarySoFar
        }
        
        return lettersPlugboardReduced
    }
    
    func testSetPlugboard() {
        let reversedPlugboardLetters = self.reversedPlugboardLetters()
        
        for firstLetter in Data.alphabet {
            for secondLetter in Data.alphabet {
                if firstLetter == secondLetter { continue }
                
                let action = SetPlugboard(firstLetter: firstLetter, secondLetter: secondLetter)
                mainStore.dispatch(action)
                
                guard let firstTextField = reversedPlugboardLetters[firstLetter] else { XCTFail(); return }
                guard let secondTextField = reversedPlugboardLetters[secondLetter] else { XCTFail(); return }
                
                XCTAssert(firstTextField.text == secondLetter)
                XCTAssert(secondTextField.text == firstLetter)
            }
        }
    }
    
    func testClearPlugboard() {
        let reversedPlugboardLetters = self.reversedPlugboardLetters()
        
        for firstLetter in Data.alphabet {
            for secondLetter in Data.alphabet {
                if firstLetter == secondLetter { continue }
                
                let setAction = SetPlugboard(firstLetter: firstLetter, secondLetter: secondLetter)
                mainStore.dispatch(setAction)
                
                guard let firstTextField = reversedPlugboardLetters[firstLetter] else { XCTFail(); return }
                guard let secondTextField = reversedPlugboardLetters[secondLetter] else { XCTFail(); return }
                
                XCTAssert(firstTextField.text == secondLetter)
                XCTAssert(secondTextField.text == firstLetter)
                
                let clearAction = ClearPlugboardPorts(firstLetter: firstLetter, secondLetter: secondLetter)
                mainStore.dispatch(clearAction)
                
                XCTAssert(firstTextField.text == "")
                XCTAssert(secondTextField.text == "")
            }
        }
    }
    
    // MARK: View
    
    func testTypePlugboard() {
        let reversedPlugboardLetters = self.reversedPlugboardLetters()
        
        var plugboardState: [String:String] {
            return mainStore.state.plugboardState.plugboard
        }
        
        for firstLetter in Data.alphabet {
            for secondLetter in Data.alphabet {
                if firstLetter == secondLetter { continue }
                
                guard let firstTextField = reversedPlugboardLetters[firstLetter] else { XCTFail(); return }
                
                firstTextField.text = secondLetter
                
                mockSetupViewController.plugboardEditingChanged(firstTextField)
                
                XCTAssert(plugboardState[firstLetter] == secondLetter)
                XCTAssert(plugboardState[secondLetter] == firstLetter)
                
                firstTextField.text = ""
                
                mockSetupViewController.plugboardEditingChanged(firstTextField)
                
                XCTAssert(plugboardState[firstLetter] == "")
                XCTAssert(plugboardState[secondLetter] == "")
            }
        }
    }
    
    // MARK: - Output Actions
    
    func testOutputActions() {
        let outputState = mainStore.state.outputState
        
        let defaultMessage = outputState.message
        
        let defaultCodeMessage = mockCodeViewController.messageLabel.text
        XCTAssert(defaultMessage == defaultCodeMessage)
        
        for letter in Data.alphabet {
            
            // Select Action
            
            let selectAction = SelectLetter(letter: letter)
            mainStore.dispatch(selectAction)
            
            guard let message = mockCodeViewController.messageLabel.text else { XCTFail(); return }
            
            guard let lastCharacter = message.characters.last else { XCTFail(); return } // No need to check for spaces because this test is also deleting letters (below).
            
            XCTAssert(String(lastCharacter) == letter)
            
            for (key, light) in mockCodeViewController.lights {
                XCTAssert(light.textColor == (key == letter ? UIColor.yellow : UIColor.lightGray))
            }
            
            // Clear Action
            
            let clearAction = ClearLetter()
            mainStore.dispatch(clearAction)
            
            for (_, light) in mockCodeViewController.lights {
                XCTAssert(light.textColor == UIColor.lightGray)
            }
            
            // Delete Action
            
            let deleteAction = DeleteLetter()
            mainStore.dispatch(deleteAction)
            
            XCTAssert(mockCodeViewController.messageLabel.text == "")
        }
    }
    
    // MARK: View
    
    // TODO: Also test that selecting a key is advancing the rotors (and deleting is undoing this)
    
    func testCodeButtons() {
        var outputState: OutputState {
            return mainStore.state.outputState
        }
        var rotorState: RotorState {
            return mainStore.state.rotorState
        }
        let initialRightRotorOffset = rotorState.rightRotorOffset
        
        guard let keyletters = mockCodeViewController.keyLetters else { XCTFail(); return }
        
        let keyLettersTuple = keyletters.map() { (button, letter) in
            return (button: button, letter: letter)
        }
        
        let keyLettersSorted = keyLettersTuple.sorted() { (first, second) in
            return first.letter < second.letter
        }
        
        for keyLetterPair in keyLettersSorted {
            guard let expectedCharacter = Helpers.encode(keyLetterPair.letter) else { XCTFail(); return }
            
            keyLetterPair.button.sendActions(for: .touchDown)
            
            XCTAssert(outputState.currentLetter == expectedCharacter)
            
            guard let lastCharacter = outputState.message.characters.last else { XCTFail(); return }
            
            XCTAssert(String(lastCharacter) == expectedCharacter)
            
            let rightRotorOffsetAfterEncoding = rotorState.rightRotorOffset
            
            XCTAssert(rightRotorOffsetAfterEncoding == initialRightRotorOffset + 1)
            
            keyLetterPair.button.sendActions(for: .touchUpInside)
            
            XCTAssert(outputState.currentLetter == nil)
            
            mockCodeViewController.deleteButton.sendActions(for: .touchUpInside)
            
            XCTAssert(outputState.message.characters.count == 0)
            
            let rightRotorOffsetAfterDelete = rotorState.rightRotorOffset
            
            XCTAssert(rightRotorOffsetAfterDelete == initialRightRotorOffset)
        }
    }
    
    
    
}
