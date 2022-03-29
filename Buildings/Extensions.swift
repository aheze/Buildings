//
//  Extensions.swift
//  Buildings
//
//  Created by A. Zheng (github.com/aheze) on 3/28/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//

import UIKit

extension UIColor {
    /// get a gradient color
    func offset(by offset: CGFloat) -> UIColor {
        let (h, s, b, a) = hsba
        var newHue = h - offset

        /// make it go back to positive
        while newHue <= 0 {
            newHue += 1
        }
        let normalizedHue = newHue.truncatingRemainder(dividingBy: 1)
        return UIColor(hue: normalizedHue, saturation: s, brightness: b, alpha: a)
    }

    var hsba: (h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat) {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return (h: h, s: s, b: b, a: a)
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}

extension UIColor {
    var color: Color {
        return Color(self)
    }
}
