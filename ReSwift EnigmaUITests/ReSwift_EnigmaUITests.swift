//
//  ReSwift_EnigmaUITests.swift
//  ReSwift EnigmaUITests
//
//  Created by James Coleman on 22/07/2017.
//  Copyright © 2017 James Coleman. All rights reserved.
//

import XCTest
// import ReSwift
// import ReSwift_Enigma

class ReSwift_EnigmaUITests: XCTestCase {
    
    var app: XCUIApplication!
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        /*
        let reflectorRotorsPicker = app.pickers["ReflectorRotorsPicker"]
        
        let reflectorComponent = app.pickerWheels["B"]
        
        reflectorComponent.adjust(toPickerWheelValue: "C")
        
        XCTAssert(mainStore.state.rotorState.reflectorRow == 2, "Reflector row has not been set")
        
        
        reflectorRotorsPicker.pickerWheels["A"].tap()
        
        let bPickerWheel = app.pickerWheels["B"]
        bPickerWheel.tap()
        
        let cPickerWheel = reflectorRotorsPicker.pickerWheels["C"]
        cPickerWheel.tap()
        bPickerWheel.swipeUp()
        cPickerWheel.swipeDown()
        bPickerWheel.swipeDown()
        bPickerWheel.tap()
        */
        
    }
    
    // MARK: Navigation
    
    func navigateToCodeScreen() {
        let navigationBars = app.navigationBars
        
        let codeNavBar = navigationBars["Code"]
        
        XCTAssert(codeNavBar.exists == false, "Code nav bar already exists")
        
        let codeButton = navigationBars["Setup"].buttons["Play"]
        
        XCTAssert(codeButton.exists, "Code button does not exist")
        
        codeButton.tap()
        
        XCTAssert(codeNavBar.exists == true, "Code nav bar does not exist")
    }
    
    func testNavigateToCodeScreen() {
        navigateToCodeScreen()
    }
    
    // MARK: Pickers
    
    func testInitialRotorPositionCarriedOverToCodeScreen() {
        
        let setupRotorInitialOffsetWheels = app.pickers["InitialRotorOffsetPicker"].pickerWheels
        
        let leftWheel = setupRotorInitialOffsetWheels.element(boundBy: 0)
        leftWheel.adjust(toPickerWheelValue: "B")
        XCTAssert(leftWheel.value as! String == "B", "Value has not been selected")
        
        let centreWheel = setupRotorInitialOffsetWheels.element(boundBy: 1)
        centreWheel.adjust(toPickerWheelValue: "C")
        XCTAssert(centreWheel.value as! String == "C", "Value has not been selected")
        
        let rightWheel = setupRotorInitialOffsetWheels.element(boundBy: 2)
        rightWheel.adjust(toPickerWheelValue: "D")
        XCTAssert(rightWheel.value as! String == "D", "Value has not been selected")
        
        navigateToCodeScreen()
        
        let rotorWindowsWheels = app.pickers["RotorWindows"].pickerWheels
        
        let leftWindow = rotorWindowsWheels.element(boundBy: 0)
        XCTAssert(leftWindow.value as! String == "B", "Selected offset has not carried over")
        
        let centreWindow = rotorWindowsWheels.element(boundBy: 1)
        XCTAssert(centreWindow.value as! String == "C", "Selected offset has not carried over")
        
        let rightWindow = rotorWindowsWheels.element(boundBy: 2)
        XCTAssert(rightWindow.value as! String == "D", "Selected offset has not carried over")
        
    }
    
    // MARK: Plugboard
    
    func ensurePlugboardAAndPlugboardBExist() {
        let textFields = app.textFields
        
        let plugboardA = textFields["PlugboardA"]
        XCTAssert(plugboardA.exists, "Plugboard A textfield does not exist")
        
        let plugboardB = textFields["PlugboardB"]
        XCTAssert(plugboardB.exists, "Plugboard B textfield does not exist")
    }
    
    func ensurePlugboardAAndPlugboardBAreEmpty() {
        let textFields = app.textFields
        
        let plugboardA = textFields["PlugboardA"]
        XCTAssert(plugboardA.value as! String == "", "Plugboard A textfield already has text in it")
        
        let plugboardB = textFields["PlugboardB"]
        XCTAssert(plugboardB.value as! String == "", "Plugboard B textfield already has text in it")
    }
    
    func testPlugboardASendsToPlugboardBTap() {
        
        ensurePlugboardAAndPlugboardBExist()
        ensurePlugboardAAndPlugboardBAreEmpty()
        
        let textFields = app.textFields
        
        let plugboardA = textFields["PlugboardA"]
        
        plugboardA.tap()
        app.keys["b"].tap()
        
        XCTAssert(plugboardA.value as! String == "B", "Plugboard A value has not been set correctly")
        
        let plugboardB = textFields["PlugboardB"]
        
        XCTAssert(plugboardB.value as! String == "A", "Plugboard B value has not been set")
        
    }
    
    func testPlugboardASendsToPlugboardBType() {
        
        ensurePlugboardAAndPlugboardBExist()
        ensurePlugboardAAndPlugboardBAreEmpty()
        
        let textFields = app.textFields
        
        let plugboardA = textFields["PlugboardA"]
        
        plugboardA.tap()
        plugboardA.typeText("b")
        
        XCTAssert(plugboardA.value as! String == "B", "Plugboard A value has not been set correctly")
        
        let plugboardB = textFields["PlugboardB"]
        
        XCTAssert(plugboardB.value as! String == "A", "Plugboard B value has not been set")
    }
    
    func testPlugboardAWillOnlyAcceptOneLetterTap() {
        ensurePlugboardAAndPlugboardBExist()
        ensurePlugboardAAndPlugboardBAreEmpty()
        
        let textFields = app.textFields
        
        let plugboardA = textFields["PlugboardA"]
        
        plugboardA.tap()
        app.keys["b"].tap()
        app.keys["c"].tap()
        
        XCTAssert(plugboardA.value as! String == "B", "Plugboard A value has not been set correctly")
    }
    
    func testPlugboardAWillOnlyAcceptOneLetterType() {
        ensurePlugboardAAndPlugboardBExist()
        ensurePlugboardAAndPlugboardBAreEmpty()
        
        let textFields = app.textFields
        
        let plugboardA = textFields["PlugboardA"]
        
        plugboardA.tap()
        plugboardA.typeText("bc")
        
        XCTAssert(plugboardA.value as! String == "B", "Plugboard A value has not been set correctly")
    }
    
    func testPlugboardAutomaticallyUppercase() {
        ensurePlugboardAAndPlugboardBExist()
        ensurePlugboardAAndPlugboardBAreEmpty()
        
        let plugboardA = app.textFields["PlugboardA"]
        
        plugboardA.tap()
        plugboardA.typeText("b")
        
        XCTAssert(plugboardA.value as! String != "b", "Plugboard A value has not been set to uppercase correctly")
        XCTAssert(plugboardA.value as! String == "B", "Plugboard A value has not been set correctly")
    }
    
    // MARK: Lightboard
    
    func testEncodingA() {
        // XCTFail("Test not implemented")
        
        navigateToCodeScreen()
        
        let aButton = app.buttons["A"]
        aButton.press(forDuration: 5)
        
        // app.buttons["A"].press(forDuration: 4.2);
        // XCUIApplication().otherElements.containing(.navigationBar, identifier:"Code").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).staticTexts["B"].tap()
        
        // XCUIApplication().staticTexts["lightB"].willChangeValue(forKey: "")
        
        
    }
    
    // MARK: Message Label
    
    func testEncodedMessageAppearsInLabel() {
        // XCTFail("Test not implemented")
        
        navigateToCodeScreen()
        
        // let messageLabel = app.staticTexts["Message"]
        // let messageLabel = app.staticTexts
        var messageLabel: String {
            return self.app.staticTexts["Message"].label
        }
        
        XCTAssert(messageLabel == "", "Message text is not empty at start")
        
        let aButton = app.buttons["A"]
        
        aButton.tap()
        aButton.tap()
        aButton.tap()
        aButton.tap()
        aButton.tap()
        
        XCTAssert(messageLabel == "BDZGO", "Message text is not the expected 'BDZGO'")
    }
    
    func testDeleteCharacter() {
        navigateToCodeScreen()
        
        var messageLabel: String {
            return app.staticTexts["Message"].label
        }
        
        XCTAssert(messageLabel == "", "Message text is not empty at start")
        
        app.buttons["A"].tap()
        
        XCTAssert(messageLabel == "B", "Message text is not 'B' as expected")
        
        app.buttons["Del"].tap()
        
        XCTAssert(messageLabel == "", "Message text is not empty again as expected")
        
    }
    
}
