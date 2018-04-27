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

