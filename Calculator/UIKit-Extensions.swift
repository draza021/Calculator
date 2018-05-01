//
//  UIKit-Extensions.swift
//  Calculator
//
//  Created by Drago on 4/27/18.
//  Copyright © 2018 iOS Akademija. All rights reserved.
//

import UIKit

extension UIButton {
    var caption: String? {
        return self.title(for: .normal)
    }
}

extension NumberFormatter {
    static let decimalFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.maximumFractionDigits = 2
        return nf
    }()
}

extension UIButton {
    private func imageWithColor(color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func setBackgroundColor(_ color: UIColor, for state: UIControlState) {
        self.setBackgroundImage(imageWithColor(color: color), for: state)
        self.setTitleColor(.white, for: .highlighted)
    }
}

