//
//  ViewController.swift
//  ReSwift Enigma
//
//  Created by James Coleman on 13/07/2017.
//  Copyright © 2017 James Coleman. All rights reserved.
//

import UIKit
import ReSwift

class SetupViewController: UIViewController {
    
    let reflectorRotorData = [
        ["A","B","C"],
        ["I","II","III"]
    ]
    
    let alphabet = ["A","B","C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

    var plugboardLetters: [UITextField:String] = [:]
    
    @IBOutlet weak var reflectorAndRotors: UIPickerView!
    @IBOutlet weak var pinOffset: UIPickerView!
    @IBOutlet weak var initialRotorOffset: UIPickerView!
    
    @IBOutlet weak var plugboardQ: UITextField!
    @IBOutlet weak var plugboardW: UITextField!
    @IBOutlet weak var plugboardE: UITextField!
    @IBOutlet weak var plugboardR: UITextField!
    @IBOutlet weak var plugboardT: UITextField!
    @IBOutlet weak var plugboardZ: UITextField!
    @IBOutlet weak var plugboardU: UITextField!
    @IBOutlet weak var plugboardI: UITextField!
    @IBOutlet weak var plugboardO: UITextField!

    @IBOutlet weak var plugboardA: UITextField!
    @IBOutlet weak var plugboardS: UITextField!
    @IBOutlet weak var plugboardD: UITextField!
    @IBOutlet weak var plugboardF: UITextField!
    @IBOutlet weak var plugboardG: UITextField!
    @IBOutlet weak var plugboardH: UITextField!
    @IBOutlet weak var plugboardJ: UITextField!
    @IBOutlet weak var plugboardK: UITextField!
    
    @IBOutlet weak var plugboardP: UITextField!
    @IBOutlet weak var plugboardY: UITextField!
    @IBOutlet weak var plugboardX: UITextField!
    @IBOutlet weak var plugboardC: UITextField!
    @IBOutlet weak var plugboardV: UITextField!
    @IBOutlet weak var plugboardB: UITextField!
    @IBOutlet weak var plugboardN: UITextField!
    @IBOutlet weak var plugboardM: UITextField!
    @IBOutlet weak var plugboardL: UITextField!
    
    @IBAction func startCoding(_ sender: UIBarButtonItem) {
        mainStore.dispatch(NavigateTo(screen: .Code))
    }
    
    @IBAction func plugboardEditingChanged(_ sender: UITextField) {
//        log.info("Sender Text: \(sender.text)")
        
        let firstLetter = sender.text?.characters.first
        let firstLetterString = firstLetter == nil ? "" : String(describing: firstLetter!)
        let firstLetterUppercase = firstLetterString.uppercased()
        
        let plugboardLetter = plugboardLetters[sender] ?? ""
        
//        log.debug("firstLetterUppercase: \(firstLetterUppercase)")
        
        if (firstLetterUppercase == "") || (alphabet.contains(firstLetterUppercase) == false) || (firstLetterUppercase == plugboardLetter) {
            // Clear the other textfield as well
        
            let clearedLetter = mainStore.state.plugboardState.plugboard[plugboardLetter] ?? ""
            
//            log.debug("clearedLetter: \(clearedLetter)")
            
            mainStore.dispatch(ClearPlugboardPorts(firstLetter: clearedLetter, secondLetter: plugboardLetter))
            
        } else {
            mainStore.dispatch(SetPlugboard(firstLetter: firstLetterUppercase, secondLetter: plugboardLetter))
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        log.debug("Setup viewDidLoad")
        
//        mainStore.subscribe(self)
        
        reflectorAndRotors.delegate = self
        reflectorAndRotors.dataSource = self
        
        pinOffset.delegate = self
        pinOffset.dataSource = self
        
        initialRotorOffset.delegate = self
        initialRotorOffset.dataSource = self
        
        plugboardLetters = [plugboardQ: "Q", plugboardW: "W", plugboardE: "E", plugboardR: "R", plugboardT: "T", plugboardZ: "Z", plugboardU: "U", plugboardI: "I", plugboardO: "O", plugboardA: "A", plugboardS: "S", plugboardD: "D", plugboardF: "F", plugboardG: "G", plugboardH: "H", plugboardJ: "J", plugboardK: "K", plugboardP: "P", plugboardY: "Y", plugboardX: "X", plugboardC: "C", plugboardV: "V", plugboardB: "B", plugboardN: "N", plugboardM: "M", plugboardL: "L"]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        log.debug("setup view will appear")
        mainStore.subscribe(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        log.debug("setup view did appear")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension SetupViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        print("row: \(row) in component: \(component)")
        switch pickerView {
        case reflectorAndRotors:
            switch component {
            case 0:
                mainStore.dispatch(SetReflector(reflector: row))
                break
            case 1:
                mainStore.dispatch(SetRotor(rotor: .left, rotorNumber: row))
            case 2:
                mainStore.dispatch(SetRotor(rotor: .centre, rotorNumber: row))
            case 3:
                mainStore.dispatch(SetRotor(rotor: .right, rotorNumber: row))
            default:
                break
        }
            
        case pinOffset:
            switch component {
            case 0:
                mainStore.dispatch(SetPinOffset(rotor: .left, pinOffset: row))
            case 1:
                mainStore.dispatch(SetPinOffset(rotor: .centre, pinOffset: row))
            case 2:
                mainStore.dispatch(SetPinOffset(rotor: .right, pinOffset: row))
            default:
                break
            }
            
        case initialRotorOffset:
            switch component {
            case 0:
                mainStore.dispatch(SetInitialPosition(rotor: .left, offset: row))
//                let difference = row - mainStore.state.setupState.leftInitialOffset
//                mainStore.dispatch(AdvanceRotor(rotor: .left, advanceBy: difference))
            case 1:
                mainStore.dispatch(SetInitialPosition(rotor: .centre, offset: row))
            case 2:
                mainStore.dispatch(SetInitialPosition(rotor: .right, offset: row))
            default:
                break
            }
            
        default:
            break

        }
    }
}

extension SetupViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch pickerView {
        case reflectorAndRotors:
            return 4
        case pinOffset, initialRotorOffset:
            return 3
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case reflectorAndRotors:
            switch component {
            case 0:
                return reflectorRotorData[0].count
            default:
                return reflectorRotorData[1].count
            }
        case pinOffset, initialRotorOffset:
            return alphabet.count
        default:
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case reflectorAndRotors:
            switch component {
            case 0:
                return reflectorRotorData[0][row]
            default:
                return reflectorRotorData[1][row]
            }
        case pinOffset:
            return "\(alphabet[row])/\(row + 1)"
        case initialRotorOffset:
            return alphabet[row]
        default:
            return nil
        }
        
    }
}

extension SetupViewController: StoreSubscriber {
    func newState(state: AppState) {
//        print("New state: ", state)
//        log.verbose(state)
        
        // Could implement 'if different' in all of this.
        
        let rotorState = state.rotorState
        
        reflectorAndRotors.selectRow(rotorState.reflectorRow, inComponent: 0, animated: false)
        reflectorAndRotors.selectRow(rotorState.leftRotorRow, inComponent: 1, animated: false)
        reflectorAndRotors.selectRow(rotorState.centreRotorRow, inComponent: 2, animated: false)
        reflectorAndRotors.selectRow(rotorState.rightRotorRow, inComponent: 3, animated: false)
        
        pinOffset.selectRow(rotorState.leftRotorPin, inComponent: 0, animated: false)
        pinOffset.selectRow(rotorState.centreRotorPin, inComponent: 1, animated: false)
        pinOffset.selectRow(rotorState.rightRotorPin, inComponent: 2, animated: false)
        
        initialRotorOffset.selectRow(rotorState.leftRotorOffset, inComponent: 0, animated: false)
        initialRotorOffset.selectRow(rotorState.centreRotorOffset, inComponent: 1, animated: false)
        initialRotorOffset.selectRow(rotorState.rightRotorOffset, inComponent: 2, animated: false)
        
        let plugboard = state.plugboardState.plugboard
        
        plugboardQ.text = plugboard["Q"]
        plugboardW.text = plugboard["W"]
        plugboardE.text = plugboard["E"]
        plugboardR.text = plugboard["R"]
        plugboardT.text = plugboard["T"]
        plugboardZ.text = plugboard["Z"]
        plugboardU.text = plugboard["U"]
        plugboardI.text = plugboard["I"]
        plugboardO.text = plugboard["O"]
        
        plugboardA.text = plugboard["A"]
        plugboardS.text = plugboard["S"]
        plugboardD.text = plugboard["D"]
        plugboardF.text = plugboard["F"]
        plugboardG.text = plugboard["G"]
        plugboardH.text = plugboard["H"]
        plugboardJ.text = plugboard["J"]
        plugboardK.text = plugboard["K"]
        
        plugboardP.text = plugboard["P"]
        plugboardY.text = plugboard["Y"]
        plugboardX.text = plugboard["X"]
        plugboardC.text = plugboard["C"]
        plugboardV.text = plugboard["V"]
        plugboardB.text = plugboard["B"]
        plugboardN.text = plugboard["N"]
        plugboardM.text = plugboard["M"]
        plugboardL.text = plugboard["L"]
        
        guard let lastScreen = state.navigationState.navigationStack.last else {
            log.error("Navigation stack is empty")
            return
        }
        
        if lastScreen != .Setup {
            switch lastScreen {
            case .Code:
                let codeViewController = storyboard?.instantiateViewController(withIdentifier: "CodeViewController") as! CodeViewController
                navigationController?.pushViewController(codeViewController, animated: true)
            default:
                break
            }
        }
    }
}
