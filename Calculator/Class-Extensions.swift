//
//  Class-Extensions.swift
//  Calculator
//
//  Created by Drago on 5/2/18.
//  Copyright © 2018 iOS Akademija. All rights reserved.
//

import Foundation
import UIKit


//MARK:- Operation functions
extension ViewController {
    
    func showResult(_ result: Double?) {
        if let result = result {
            resultLabel.text = "\( NumberFormatter.decimalFormatter.string(for: result)  ?? "" )"
        }
    }
    
    func add() -> Double? {
        if let firstOperand = firstOperand, let secondOperand = secondOperand {
            return firstOperand + secondOperand
        }
        return nil
    }
    
    func subtract() -> Double? {
        if let firstOperand = firstOperand, let secondOperand = secondOperand {
            return firstOperand - secondOperand
        }
        return nil
    }
    
    func divide() -> Double? {
        if let firstOperand = firstOperand, let secondOperand = secondOperand {
            return firstOperand / secondOperand
        }
        return nil
    }
    
    func multiply() -> Double? {
        if let firstOperand = firstOperand, let secondOperand = secondOperand {
            return firstOperand * secondOperand
        }
        return nil
    }
}

//MARK:- Functions
extension ViewController {
    
    func extractOperationFromSender(with caption: String?) -> Operation? {
        if let caption = caption {
            switch caption {
            case "+":
                return .add
            case "-":
                return .subtract
            case "÷":
                return .divide
            case "X":
                return .multiply
            case "=":
                return .equal
            default:
                break
            }
        }
        return nil
    }
    
    func extractOperand() -> Double? {
        let textFromResultLabel = resultLabel.text ?? ""
        return NumberFormatter.decimalFormatter.number(from: textFromResultLabel)?.doubleValue
    }
    
    func cleanupUI() {
        resultLabel.text = nil
    }
    
    func applyThemeForOperatorButtons(with color: UIColor, fontSize: CGFloat) {
        for button in operatorButtons {
            button.backgroundColor = color
        }
        
        for button in allButtons {
            if let font = button.titleLabel?.font {
                button.titleLabel?.font = font.withSize(fontSize)
            }
        }
    }
    
    func setAllButtonsBackground(_ color: UIColor, for state: UIControlState) {
        for button in allButtons {
            button.setBackgroundColor(color, for: state)
        }
    }
    
    func setupDigitButtonTaps() {
        for button in digitButtons {
            button.addTarget(self, action: #selector(ViewController.didTapDigit), for: .touchUpInside)
        }
    }
    
    func setupOperatorButtonTaps() {
        for button in operatorButtons {
            button.addTarget(self, action: #selector(ViewController.didTapOperator), for: .touchUpInside)
        }
    }
    
    func setupDotCaption() {
        let s = Locale.current.decimalSeparator
        dotButton.setTitle(s, for: .normal)
    }
    
    func resetOperation() {
        firstOperand = nil
        secondOperand = nil
        self.operation = nil
    }
    
    func checkForOperatorInResultLabel(_ textFromResultLabel: inout String, _ caption: String) {
        if !operatorCaptions.contains(textFromResultLabel) {
            textFromResultLabel += caption
            resultLabel.text = textFromResultLabel
        } else {
            resultLabel.text = nil
            textFromResultLabel = caption
            resultLabel.text = textFromResultLabel
        }
    }
    
    func showOperator(_ operationCaption: String?) {
        if let operationCaption = operationCaption {
            clearAll()
            resultLabel.text = operationCaption
        }
    }
}

//MARK:- Align ZERO button functions
extension ViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        let insetValue = btnZero.frame.size.width / 2
        print("viewDIdAppear")
        print(insetValue)
        
        btnZero.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: insetValue)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { [weak self] btnZero in
            let insetValue = (self?.btnZero.frame.size.width)! / 2
            print("viewWillTransition")
            print(insetValue)
            
            self?.btnZero.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: insetValue)
        }
    }
}


