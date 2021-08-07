//
// Created by 李和 on 2021/8/5.
//

import SwiftUI

func parseHex(_ hex: String) -> Color {

    var data = hex
    if(hex.starts(with: "#")){
        data = data.slice(begin: 1)
    }
    var red = 0.0, green = 0.0, blue = 0.0, opacity = 0.0
    if(data.count >= 6){
        //分割
        red = hex2decimal(data.slice(begin: 0, len: 2)).toDouble() / 255.0
        green = hex2decimal(data.slice(begin: 2, len: 2)).toDouble() / 255.0
        blue = hex2decimal(data.slice(begin: 4, len: 2)).toDouble() / 255.0
    }
    if(data.count == 8){
        opacity = hex2decimal(data.slice(begin: 6, len: 2)).toDouble() / 255.0
    }
    return Color(red: red, green: green, blue: blue, opacity: opacity)

}