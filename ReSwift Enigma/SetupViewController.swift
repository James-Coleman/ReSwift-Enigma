//
//  ViewController.swift
//  ReSwift Enigma
//
//  Created by James Coleman on 13/07/2017.
//  Copyright © 2017 James Coleman. All rights reserved.
//

import UIKit
import ReSwift

class SetupViewController: UIViewController, UIPickerViewDelegate {
    
    let reflectorRotorData = [
        ["A","B","C"],
        ["I","II","III"]
    ]
    
    var plugboardLetters: [UITextField:String]!
    
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
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBAction func startCoding(_ sender: UIBarButtonItem) {
        mainStore.dispatch(NavigateTo(screen: .CodeViewController))
    }
    
    @IBAction func plugboardEditingChanged(_ sender: UITextField) {
        //        log.info("Sender Text: \(sender.text)")
        
        let firstLetter = sender.text?.first
        let firstLetterString = firstLetter == nil ? "" : String(describing: firstLetter!)
        let firstLetterUppercase = firstLetterString.uppercased()
        
        let plugboardLetter = plugboardLetters[sender] ?? ""
        
        //        log.debug("firstLetterUppercase: \(firstLetterUppercase)")
        
        if (firstLetterUppercase == "") || (Data.alphabet.contains(firstLetterUppercase) == false) || (firstLetterUppercase == plugboardLetter) {
            // Clear the other textfield as well
            
            let clearedLetter = mainStore.state.plugboardState.plugboard[plugboardLetter] ?? ""
            
            //            log.debug("clearedLetter: \(clearedLetter)")
            
            mainStore.dispatch(ClearPlugboardPorts(firstLetter: clearedLetter, secondLetter: plugboardLetter))
            
        } else {
            mainStore.dispatch(SetPlugboard(firstLetter: firstLetterUppercase, secondLetter: plugboardLetter))
        }
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            // print("Show")
            log.debug("Keyboard size: \(keyboardSize)")
            let keyboardHeight = keyboardSize.height
        
            topConstraint.constant = -keyboardHeight - 8
            bottomConstraint.constant = keyboardHeight + 8
            
            view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let _ = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue { // keyboardSize
            // print("Hide")
            topConstraint.constant = 8
            bottomConstraint.constant = 8
            
            view.layoutIfNeeded()
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
        
        plugboardQ.delegate = self
        plugboardW.delegate = self
        plugboardE.delegate = self
        plugboardR.delegate = self
        plugboardT.delegate = self
        plugboardZ.delegate = self
        plugboardU.delegate = self
        plugboardI.delegate = self
        plugboardO.delegate = self
        
        plugboardA.delegate = self
        plugboardS.delegate = self
        plugboardD.delegate = self
        plugboardF.delegate = self
        plugboardG.delegate = self
        plugboardH.delegate = self
        plugboardJ.delegate = self
        plugboardK.delegate = self
        
        plugboardP.delegate = self
        plugboardY.delegate = self
        plugboardX.delegate = self
        plugboardC.delegate = self
        plugboardV.delegate = self
        plugboardB.delegate = self
        plugboardN.delegate = self
        plugboardM.delegate = self
        plugboardL.delegate = self
        
        plugboardLetters = [plugboardQ: "Q", plugboardW: "W", plugboardE: "E", plugboardR: "R", plugboardT: "T", plugboardZ: "Z", plugboardU: "U", plugboardI: "I", plugboardO: "O", plugboardA: "A", plugboardS: "S", plugboardD: "D", plugboardF: "F", plugboardG: "G", plugboardH: "H", plugboardJ: "J", plugboardK: "K", plugboardP: "P", plugboardY: "Y", plugboardX: "X", plugboardC: "C", plugboardV: "V", plugboardB: "B", plugboardN: "N", plugboardM: "M", plugboardL: "L"]
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//                log.debug("setup view will appear")
        mainStore.subscribe(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        log.debug("setup view did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainStore.unsubscribe(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        log.debug("pickerview did select row: \(row) in component: \(component)")
        switch pickerView {
        case reflectorAndRotors:
            switch component {
            case 0:
                mainStore.dispatch(SetReflector(reflector: row))
                break
            case 1:
                mainStore.dispatch(SetRotor(rotor: .left,   rotorNumber: row))
            case 2:
                mainStore.dispatch(SetRotor(rotor: .centre, rotorNumber: row))
            case 3:
                mainStore.dispatch(SetRotor(rotor: .right,  rotorNumber: row))
            default:
                break
            }
            
        case pinOffset:
            switch component {
            case 0:
                mainStore.dispatch(SetPinOffset(rotor: .left,   pinOffset: row))
            case 1:
                mainStore.dispatch(SetPinOffset(rotor: .centre, pinOffset: row))
            case 2:
                mainStore.dispatch(SetPinOffset(rotor: .right,  pinOffset: row))
            default:
                break
            }
            
        case initialRotorOffset:
            switch component {
            case 0:
                mainStore.dispatch(SetInitialPosition(rotor: .left,     offset: row))
            case 1:
                mainStore.dispatch(SetInitialPosition(rotor: .centre,   offset: row))
            case 2:
                mainStore.dispatch(SetInitialPosition(rotor: .right,    offset: row))
            default:
                break
            }
            
        default:
            break
            
        }
    }
    
}

//extension SetupViewController: UIPickerViewDelegate {
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        log.debug("pickerview did select row: \(row) in component: \(component)")di
//        switch pickerView {
//        case reflectorAndRotors:
//            switch component {
//            case 0:
//                mainStore.dispatch(SetReflector(reflector: row))
//                break
//            case 1:
//                mainStore.dispatch(SetRotor(rotor: .left,   rotorNumber: row))
//            case 2:
//                mainStore.dispatch(SetRotor(rotor: .centre, rotorNumber: row))
//            case 3:
//                mainStore.dispatch(SetRotor(rotor: .right,  rotorNumber: row))
//            default:
//                break
//            }
//            
//        case pinOffset:
//            switch component {
//            case 0:
//                mainStore.dispatch(SetPinOffset(rotor: .left,   pinOffset: row))
//            case 1:
//                mainStore.dispatch(SetPinOffset(rotor: .centre, pinOffset: row))
//            case 2:
//                mainStore.dispatch(SetPinOffset(rotor: .right,  pinOffset: row))
//            default:
//                break
//            }
//            
//        case initialRotorOffset:
//            switch component {
//            case 0:
//                mainStore.dispatch(SetInitialPosition(rotor: .left,     offset: row))
//            case 1:
//                mainStore.dispatch(SetInitialPosition(rotor: .centre,   offset: row))
//            case 2:
//                mainStore.dispatch(SetInitialPosition(rotor: .right,    offset: row))
//            default:
//                break
//            }
//            
//        default:
//            break
//            
//        }
//    }
//}

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
            return Data.alphabetCount
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
            return "\(Data.alphabet[row])/\(row + 1)"
        case initialRotorOffset:
            return Data.alphabet[row]
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
        
        reflectorAndRotors.selectRow(rotorState.reflectorRow,   inComponent: 0, animated: false)
        reflectorAndRotors.selectRow(rotorState.leftRotorRow,   inComponent: 1, animated: false)
        reflectorAndRotors.selectRow(rotorState.centreRotorRow, inComponent: 2, animated: false)
        reflectorAndRotors.selectRow(rotorState.rightRotorRow,  inComponent: 3, animated: false)
        
        pinOffset.selectRow(rotorState.leftRotorPin,    inComponent: 0, animated: false)
        pinOffset.selectRow(rotorState.centreRotorPin,  inComponent: 1, animated: false)
        pinOffset.selectRow(rotorState.rightRotorPin,   inComponent: 2, animated: false)
        
        initialRotorOffset.selectRow(rotorState.leftRotorOffset,    inComponent: 0, animated: false)
        initialRotorOffset.selectRow(rotorState.centreRotorOffset,  inComponent: 1, animated: false)
        initialRotorOffset.selectRow(rotorState.rightRotorOffset,   inComponent: 2, animated: false)
        
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
        
        if lastScreen != .SetupViewController {
            switch lastScreen {
            case .CodeViewController:
                let codeViewController = storyboard?.instantiateViewController(withIdentifier: Screen.CodeViewController.rawValue) as! CodeViewController
                navigationController?.pushViewController(codeViewController, animated: true)
            default:
                break
            }
        }
    }
}

extension SetupViewController: UITextFieldDelegate {
    // https://stackoverflow.com/questions/24180954/how-to-hide-keyboard-in-swift-on-pressing-return-key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}
