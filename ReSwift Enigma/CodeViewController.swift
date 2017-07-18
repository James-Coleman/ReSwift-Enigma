//
//  CodeViewController.swift
//  ReSwift Enigma
//
//  Created by James Coleman on 15/07/2017.
//  Copyright © 2017 James Coleman. All rights reserved.
//

import UIKit
import ReSwift

class CodeViewController: UIViewController {
    
    let alphabet = ["A","B","C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    var lights: [String:UILabel] = [:]
    var keyLetters: [UIButton:String] = [:]
    
    @IBOutlet weak var rotors: UIPickerView!
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    // MARK: Lightboard
    
    @IBOutlet weak var lightQ: UILabel!
    @IBOutlet weak var lightW: UILabel!
    @IBOutlet weak var lightE: UILabel!
    @IBOutlet weak var lightR: UILabel!
    @IBOutlet weak var lightT: UILabel!
    @IBOutlet weak var lightZ: UILabel!
    @IBOutlet weak var lightU: UILabel!
    @IBOutlet weak var lightI: UILabel!
    @IBOutlet weak var lightO: UILabel!
    
    @IBOutlet weak var lightA: UILabel!
    @IBOutlet weak var lightS: UILabel!
    @IBOutlet weak var lightD: UILabel!
    @IBOutlet weak var lightF: UILabel!
    @IBOutlet weak var lightG: UILabel!
    @IBOutlet weak var lightH: UILabel!
    @IBOutlet weak var lightJ: UILabel!
    @IBOutlet weak var lightK: UILabel!
    
    @IBOutlet weak var lightP: UILabel!
    @IBOutlet weak var lightY: UILabel!
    @IBOutlet weak var lightX: UILabel!
    @IBOutlet weak var lightC: UILabel!
    @IBOutlet weak var lightV: UILabel!
    @IBOutlet weak var lightB: UILabel!
    @IBOutlet weak var lightN: UILabel!
    @IBOutlet weak var lightM: UILabel!
    @IBOutlet weak var lightL: UILabel!
    
    // MARK: Keys
    
    @IBOutlet weak var keyQ: UIButton!
    @IBOutlet weak var keyW: UIButton!
    @IBOutlet weak var keyE: UIButton!
    @IBOutlet weak var keyR: UIButton!
    @IBOutlet weak var keyT: UIButton!
    @IBOutlet weak var keyZ: UIButton!
    @IBOutlet weak var keyU: UIButton!
    @IBOutlet weak var keyI: UIButton!
    @IBOutlet weak var keyO: UIButton!
    
    @IBOutlet weak var keyA: UIButton!
    @IBOutlet weak var keyS: UIButton!
    @IBOutlet weak var keyD: UIButton!
    @IBOutlet weak var keyF: UIButton!
    @IBOutlet weak var keyG: UIButton!
    @IBOutlet weak var keyH: UIButton!
    @IBOutlet weak var keyJ: UIButton!
    @IBOutlet weak var keyK: UIButton!
    
    @IBOutlet weak var keyP: UIButton!
    @IBOutlet weak var keyY: UIButton!
    @IBOutlet weak var keyX: UIButton!
    @IBOutlet weak var keyC: UIButton!
    @IBOutlet weak var keyV: UIButton!
    @IBOutlet weak var keyB: UIButton!
    @IBOutlet weak var keyN: UIButton!
    @IBOutlet weak var keyM: UIButton!
    @IBOutlet weak var keyL: UIButton!
    
    @IBAction func deleteLetter(_ sender: Any) {
        mainStore.dispatch(DeleteLetter())
    }
    
    @IBAction func keyTouchDown(_ sender: UIButton) {
        guard let letter = keyLetters[sender] else { return }
        guard let encodedLetter = encode(letter: letter) else { return }
        
        mainStore.dispatch(SelectLetter(letter: encodedLetter))
    }
    
    @IBAction func keyTouchUpInside(_ sender: UIButton) {
        mainStore.dispatch(ClearLetter())
    }
    
    @IBAction func keyTouchUpOutside(_ sender: UIButton) {
        mainStore.dispatch(ClearLetter())
    }
    
    func encode(letter: String) -> String? {
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
    
    /*
    func encodeLetter(letter: String) -> String? {
        let workingState = mainStore.state.workingState
        
        let rightRotorWiring = workingState.rightRotor.wiring
        let centreRotorWiring = workingState.centreRotor.wiring
        let leftRotorWiring = workingState.leftRotor.wiring
        
        let reflectorWiring = workingState.reflector.wiring
        
        guard let rightLetter = rightRotorWiring[letter] else { return nil }
        guard let centreLetter = centreRotorWiring[rightLetter] else { return nil }
        guard let leftLetter = leftRotorWiring[centreLetter] else { return nil }
        
        guard let reflectedLetter = reflectorWiring[leftLetter] else { return nil }
        
        guard let reflectedLeftLetter = leftRotorWiring[reflectedLetter] else { return nil }
        guard let reflectedCentreLetter = centreRotorWiring[reflectedLeftLetter] else { return nil }
        guard let reflectedRightLetter = rightRotorWiring[reflectedCentreLetter] else { return nil }
        
        return reflectedRightLetter
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
//        mainStore.subscribe(self)
        
        rotors.dataSource = self
        rotors.delegate = self
        
        lights = ["Q":lightQ, "W":lightW, "E":lightE, "R":lightR, "T":lightT, "Z":lightZ, "U":lightU, "I":lightI, "O":lightO, "A":lightA, "S":lightS, "D":lightD, "F":lightF, "G":lightG, "H":lightH, "J":lightJ, "K":lightK, "P":lightP, "Y":lightY, "X":lightX, "C":lightC, "V":lightV, "B":lightB, "N":lightN, "M":lightM, "L":lightL]
        
        keyLetters = [keyQ:"Q", keyW:"W", keyE:"E", keyR:"R", keyT:"T", keyZ:"Z", keyU:"U", keyI:"I", keyO:"O", keyA:"A", keyS:"S", keyD:"D", keyF:"F", keyG:"G", keyH:"H", keyJ:"J", keyK:"K", keyP:"P", keyY:"Y", keyX:"X", keyC:"C", keyV:"V", keyB:"B", keyN:"N", keyM:"M", keyL:"L"]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainStore.subscribe(self)
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        super.willMove(toParentViewController: parent)
        
//        log.debug(parent)
        
        if parent == nil {
            mainStore.dispatch(PopBack())
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension CodeViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return alphabet.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return alphabet[row]
    }
}

extension CodeViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            mainStore.dispatch(SetInitialPosition(rotor: .left, offset: row))
            
        case 1:
            mainStore.dispatch(SetInitialPosition(rotor: .centre, offset: row))
            
        case 2:
            mainStore.dispatch(SetInitialPosition(rotor: .right, offset: row))
            
        default:
            break
        }
    }
}

extension CodeViewController: StoreSubscriber {
    func newState(state: AppState) {
//        let workingState = state.workingState
        
//        let selectedLetter = workingState.selectedLetter ?? ""

        // Could replace this with a map?
//        for (letter, light) in lights {
//            light.textColor = letter == selectedLetter ? .yellow : .lightGray
//        }
        
        let rotorState = state.rotorState
        
        rotors.selectRow(rotorState.leftRotorOffset, inComponent: 0, animated: true)
        rotors.selectRow(rotorState.centreRotorOffset, inComponent: 1, animated: true)
        rotors.selectRow(rotorState.rightRotorOffset, inComponent: 2, animated: true)
        
        let outputState = state.outputState
        
        lights.map { (letter, label) in
            label.textColor = outputState.currentLetter == letter ? .yellow : .lightGray
        }
        
        messageLabel.text = outputState.message
        deleteButton.isEnabled = outputState.message.characters.count > 0
        
    }
}
