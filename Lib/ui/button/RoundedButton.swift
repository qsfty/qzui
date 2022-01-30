//
// Created by 强子 on 2021/8/7.
//

import SwiftUI


/**
 * 圆角矩形
 */
public struct RoundedButton: View {

    public var name: String
    public var fontSize: CGFloat = 14
    public var width: CGFloat = -1
    public var height: CGFloat = -1
    public var color: Color = Color.white
    public var bg: Color = Color.theme
    public var radius: Int = 10
    public var action: () -> Void


    public init(_ name: String, fontSize: CGFloat = 14, width: CGFloat = -1, height: CGFloat = -1,  radius: Int = 4,color: Color = Color.white, bg: Color = Color.theme, action: @escaping () -> ()) {
        self.name = name
        self.fontSize = fontSize
        self.width = width
        self.height = height
        self.color = color
        self.bg = bg
        self.radius = radius
        self.action = action
    }

    public static func  long(_ name: String, action: @escaping () -> ()) -> RoundedButton {
        RoundedButton(name, width: MyUIUtil.fullWidth() - 80, height: 40, radius: 20, action: action)
    }
    public var body: some View {
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
