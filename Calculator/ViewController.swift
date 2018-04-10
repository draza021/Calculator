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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let insetValue = btnZero.frame.size.width / 2
        print("viewDIdAppear")
        print(insetValue)
        
        btnZero.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: insetValue)
    }
  
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { [unowned self] btnZero in
            let insetValue = self.btnZero.frame.size.width / 2
            print("viewWillTransition")
            print(insetValue)
            
            self.btnZero.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: insetValue)
        }
    }
}

