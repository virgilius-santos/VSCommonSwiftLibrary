//
//  UIColorExtensions.swift
//  VCore
//
//  Created by Virgilius Santos on 19/01/20.
//  Copyright © 2020 Virgilius Santos. All rights reserved.
//

import UIKit

public extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat) {
        self.init(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: alpha)
    }
}

