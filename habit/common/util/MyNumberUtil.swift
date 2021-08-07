//
// Created by 李和 on 2021/8/5.
//

import SwiftUI

extension Int {

    func toFloat() -> CGFloat{
        CGFloat(self)
    }

    func toDouble() -> Double{
        Double(self)
    }

    func toFixed(_ len: Int) -> Double {
        (self.toDouble() * pow(10, len.toDouble())).rounded() / pow(10, len.toDouble())
    }
}

extension CGFloat {

    func toInt() -> Int{
        Int(self)
    }

    func toDouble() -> Double{
        Double(self)
    }

    func toFixed(_ len: Int) -> Double {
        (self.toDouble() * pow(10, len.toDouble())).rounded() / pow(10, len.toDouble())
    }
}




extension Double {

    func toInt() -> Int{
        Int(self)
    }

    func toFloat() -> CGFloat{
        CGFloat(self)
    }

    func toFixed(_ len: Int) -> Double {
        (self * pow(10, len.toDouble())).rounded() / pow(10, len.toDouble())
    }
}

func hex2decimal(_ num: String) -> Int{
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


