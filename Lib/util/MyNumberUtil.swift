//
// Created by 李和 on 2021/8/5.
//

import SwiftUI

extension Int {

    public func toFloat() -> CGFloat{
        CGFloat(self)
    }

    public func toDouble() -> Double{
        Double(self)
    }

    public func toFixed(_ len: Int) -> Double {
        (self.toDouble() * pow(10, len.toDouble())).rounded() / pow(10, len.toDouble())
    }
    public func toAbs() -> Int {
        Int(abs(self))
    }

    public func toString() -> String {
        String(describing: self)
    }
}

extension CGFloat {

    public func toInt() -> Int{
        Int(self)
    }

    public func toDouble() -> Double{
        Double(self)
    }

    public func toFixed(_ len: Int) -> Double {
        (self.toDouble() * pow(10, len.toDouble())).rounded() / pow(10, len.toDouble())
    }

    public func toAbs() -> Int {
        Int(abs(self))
    }
}




extension Double {

    public func toInt() -> Int{
        Int(self)
    }

    public func toFloat() -> CGFloat{
        CGFloat(self)
    }

    public func toFixed(_ len: Int) -> Double {
        (self * pow(10, len.toDouble())).rounded() / pow(10, len.toDouble())
    }

    public func toAbs() -> Int {
        Int(abs(self))
    }
}

public func hex2decimal(_ num: String) -> Int{
    var sum: Int = 0
    let str: String = num.uppercased()
    for i in str.utf8 {
        sum = sum * 16 + Int(i) - 48
        if i >= 65 {
            sum -= 7
        }
    }
    return sum
}


