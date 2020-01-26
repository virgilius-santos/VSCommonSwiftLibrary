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
    
    func modified(withAdditionalHue hue: CGFloat = CGFloat.zero,
                  additionalSaturation: CGFloat = CGFloat.zero,
                  additionalBrightness: CGFloat = CGFloat.zero) -> UIColor {
        
        var currentHue: CGFloat = 0.0
        var currentSaturation: CGFloat = 0.0
        var currentBrigthness: CGFloat = 0.0
        var currentAlpha: CGFloat = 0.0
        
        if self.getHue(&currentHue, saturation: &currentSaturation, brightness: &currentBrigthness, alpha: &currentAlpha){
            return UIColor(hue: currentHue + hue,
                           saturation: currentSaturation + additionalSaturation,
                           brightness: currentBrigthness + additionalBrightness,
                           alpha: currentAlpha)
        } else {
            return self
        }
    }
}

