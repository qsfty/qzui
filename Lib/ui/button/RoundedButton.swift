//
// Created by 强子 on 2021/8/7.
//

import SwiftUI

/**
 * 圆角矩形
 */
struct RoundedButton: View {

    var name: String
    var fontSize: CGFloat = 14
    var width: CGFloat = -1
    var height: CGFloat = -1
    var color: Color = Color.white
    var bg: Color = Color("button0")
    var radius: Int = 10
    var action: () -> Void


    init(_ name: String, fontSize: CGFloat = 14, width: CGFloat = -1, height: CGFloat = -1,  radius: Int = 4,color: Color = Color.white, bg: Color = Color("button0"), action: @escaping () -> ()) {
        self.name = name
        self.fontSize = fontSize
        self.width = width
        self.height = height
        self.color = color
        self.bg = bg
        self.radius = radius
        self.action = action
    }

    static func long(_ name: String, action: @escaping () -> ()) -> RoundedButton {
        RoundedButton(name, width: UIUtils.fullWidth() - 80, height: 40, radius: 20, action: action)
    }
    var body: some View {
        Text(self.name)
                .fontSize(fontSize)
                .width(width)
                .height(height)
                .foregroundColor(color)
                .background(bg)
                .cornerRadius(radius.toFloat())
                .onTapGesture{
                    action()
                }
    }
}
