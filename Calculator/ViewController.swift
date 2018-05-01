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
        if operation == nil {
            firstOperand = extractOperand()
            resultLabel.text = nil
        } else {
            secondOperand = extractOperand()
            resultLabel.text = nil
        }
        
        if let operationCaption = extractOperationFrom(sender, with: sender.caption) {
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

//MARK:- Functions
private extension ViewController {
    
    func extractOperationFrom(_ sender: UIButton, with caption: String?) -> Operation? {
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
    
    func disableOperators() {
        for button in operatorButtons {
            if let caption = button.caption {
                if caption == "=" { continue }
                button.isUserInteractionEnabled = false
                button.alpha = 0.5
            }
        }
    }
    
    func enableOperators() {
        for button in operatorButtons {
            button.isUserInteractionEnabled = true
            button.alpha = 1
        }
    }
    
    func resetOperation() {
        firstOperand = nil
        secondOperand = nil
        self.operation = nil
    }
}

//MARK:- Operation functions
private extension ViewController {
    
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

