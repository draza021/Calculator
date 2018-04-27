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
    
    enum Operation {
        case add, subtract, divide, multiply
        case equal
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cleanupUI()
        applyTheme(with: .brown, fontSize: 35)
        setupDigitButtonTaps()
        
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
        if let caption = sender.title(for: .normal) {
            var textFromResultLabel = resultLabel.text ?? ""
            textFromResultLabel += caption
            resultLabel.text = textFromResultLabel
        }
    }
    
    @IBAction func didTapOperator(_ sender: UIButton) {
//        if let caption = sender.title(for: .normal) {
//            var textFromResultLabel = resultLabel.text ?? ""
//
//            if let convertedValue = Double(textFromResultLabel) {
//                firstOperand = convertedValue
//            }
//        }
    }
    
}

//MARK:- Functions
extension ViewController {
    
    func cleanupUI() {
        clearAll()
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
            button.addTarget(self, action: #selector(ViewController.didTapDigit(_:)), for: .touchUpInside)
        }
    }
    
    
}

