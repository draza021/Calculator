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
        applyTheme(with: .brown, fontSize: 35)
        setupDigitButtonTaps()
        setupOperatorButtonTaps()
        setupDotCaption()
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
        }
        
        if let caption = sender.caption {
            switch caption {
            case "+":
                operation = .add
            case "-":
                operation = .subtract
            case "÷":
                operation = .divide
            case "X":
                operation = .multiply
            case "=":
                secondOperand = extractOperand()
                
                if let operation = operation {
                    switch operation {
                    case .add:
                        let result = (firstOperand ?? 0) + (secondOperand ?? 0)
                        resultLabel.text = "\( result )"
                    default:
                        break
                    }
                    
                    for button in operatorButtons {
                        button.isUserInteractionEnabled = true
                        button.alpha = 1
                    }
                    
                    firstOperand = nil
                    secondOperand = nil
                    self.operation = nil
                }
                
            default:
                break
            }
            
            for button in operatorButtons {
                if let caption = button.caption {
                    if caption == "=" { continue }
                    button.isUserInteractionEnabled = false
                    button.alpha = 0.5
                }
            }
        }
    }
}

//MARK:- Functions
extension ViewController {
    
    func extractOperand() -> Double? {
        let textFromResultLabel = resultLabel.text ?? ""
        return NumberFormatter.decimalFormatter.number(from: textFromResultLabel)?.doubleValue
    }
    
    func cleanupUI() {
        resultLabel.text = nil
    }
    
    func applyTheme(with color: UIColor, fontSize: CGFloat) {
        for button in operatorButtons {
            button.backgroundColor = color
        }
        
        for button in allButtons {
            if let font = button.titleLabel?.font {
                button.titleLabel?.font = font.withSize(fontSize)
            }
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
    
    
}

