//
// Created by 强子 on 2021/8/7.
//

import UIKit
import SwiftUI


extension UIColor {

    // Check if the color is light or dark, as defined by the injected lightness threshold.
    // Some people report that 0.7 is best. I suggest to find out for yourself.
    // A nil value is returned if the lightness couldn't be determined.
    func isLight(threshold: Float = 0.5) -> Bool {
        let originalCGColor = self.cgColor

        // Now we need to convert it to the RGB colorspace. UIColor.white / UIColor.black are greyscale and not RGB.
        // If you don't do this then you will crash when accessing components index 2 below when evaluating greyscale colors.
        let RGBCGColor = originalCGColor.converted(to: CGColorSpaceCreateDeviceRGB(), intent: .defaultIntent, options: nil)
        guard let components = RGBCGColor?.components else {
            return true
        }
        guard components.count >= 3 else {
            return true
        }

        let brightness = Float(((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000)
        return (brightness > threshold)
    }

    func hexValue() -> String {
        let values = self.cgColor.components
        var outputR: Int = 0
        var outputG: Int = 0
        var outputB: Int = 0
        var outputA: Int = 1

        switch values!.count {
        case 1:
            outputR = Int(values![0] * 255)
            outputG = Int(values![0] * 255)
            outputB = Int(values![0] * 255)
            outputA = 1
        case 2:
            outputR = Int(values![0] * 255)
            outputG = Int(values![0] * 255)
            outputB = Int(values![0] * 255)
            outputA = Int(values![1] * 255)
        case 3:
            outputR = Int(values![0] * 255)
            outputG = Int(values![1] * 255)
            outputB = Int(values![2] * 255)
            outputA = 1
        case 4:
            outputR = Int(values![0] * 255)
            outputG = Int(values![1] * 255)
            outputB = Int(values![2] * 255)
            outputA = Int(values![3] * 255)
        default:
            break
        }
        return "#" + String(format:"%02X", outputR) + String(format:"%02X", outputG) + String(format:"%02X", outputB) + String(format:"%02X", outputA)
    }

}


extension Color {

    func uiColor() -> UIColor {
        return UIColor(self)
    }

    func stringify() -> String {
        let v = self.uiColor().hexValue()
        if(String(v.reversed()).starts(with: "FF")){
            return v.slice(begin: 0, end: 2)
        }
        return v
    }

}