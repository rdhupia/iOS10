//
//  DesignableButton.swift
//  BudgetApp
//
//  Created by Ravideep Dhupia on 2017-02-18.
//  Copyright © 2017 Ravideep Dhupia. All rights reserved.
//

import UIKit

// Inheriting UIButton, adding functionality on top of it. Mark it as a type of class. IB - Interface Builder
@IBDesignable
class DesignableButton: UIButton {

    // Give a border to button
    // MARK: Add a prop that can be inspected insidi attribute inspector
    @IBInspectable
    var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

}
