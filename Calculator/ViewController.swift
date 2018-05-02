//
//  ViewController.swift
//  Calculator
//
//  Created by iOS Akademija on 3/28/18.
//  Copyright © 2018 iOS Akademija. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var btnZero: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var dotButton: UIButton!
    @IBOutlet var operatorButtons: [UIButton]!
    @IBOutlet var digitButtons: [UIButton]!
    
    var allButtons: [UIButton] {
        return operatorButtons + digitButtons + [dotButton]
    }
    
    //MARK:- Data model
    var firstOperand: Double?
    var secondOperand: Double?
    var operation: Operation?
    
    enum Operation {
        case add, subtract, divide, multiply
        case equal
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cleanupUI()
        applyThemeForOperatorButtons(with: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1) , fontSize: 35)
        setupDigitButtonTaps()
        setupOperatorButtonTaps()
        setupDotCaption()
        setAllButtonsBackground(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .highlighted)
    }
}

//MARK:- IBActions
extension ViewController {
    
    @IBAction func clearAll() {
        cleanupUI()
    }
    
    @IBAction func didTapDigit(_ sender: UIButton) {
        if let caption = sender.caption {
            var textFromResultLabel = resultLabel.text ?? ""
            textFromResultLabel += caption
            resultLabel.text = textFromResultLabel
        }
    }
    
    @IBAction func didTapDot(_ sender: UIButton) {
        if let caption = sender.caption {
            var textFromResultLabel = resultLabel.text ?? ""
            if !textFromResultLabel.contains(caption) {
                textFromResultLabel += caption
                resultLabel.text = textFromResultLabel
            }
        }
    }
    
    @IBAction func didTapOperator(_ sender: UIButton) {
        if resultLabel.text == nil { return }
        if operation == nil {
            firstOperand = extractOperand()
            resultLabel.text = nil
        } else {
            secondOperand = extractOperand()
            resultLabel.text = nil
        }
        
        if let operationCaption = extractOperationFromSender(with: sender.caption) {
            switch operationCaption {
            case .add:
                operation = .add
                disableOperators()
            case .subtract:
                operation = .subtract
                disableOperators()
            case .divide:
                operation = .divide
                disableOperators()
            case .multiply:
                operation = .multiply
                disableOperators()
            case .equal:
                if let operation = operation {
                    var result: Double?
                    switch operation {
                    case .add:
                        result = add()
                    case .subtract:
                        result = subtract()
                    case .divide:
                        result = divide()
                    case .multiply:
                        result = multiply()
                    default:
                        break
                    }
                    showResult(result)
                    enableOperators()
                    resetOperation()
                }
            }
        }
    }
}





