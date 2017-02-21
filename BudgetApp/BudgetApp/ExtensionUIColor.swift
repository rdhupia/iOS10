//
//  ExtensionUIColor.swift
//  BudgetApp
//
//  Created by Ravideep Dhupia on 2017-02-20.
//  Copyright © 2017 Ravideep Dhupia. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
