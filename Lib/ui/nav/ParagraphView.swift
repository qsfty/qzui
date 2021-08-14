//
// Created by 强子 on 2021/8/7.
//


import SwiftUI


public struct ParagraphView: View {

    var content: String
    var lineHeight: Int = 0

    public init(_ content: String, style: LineSize = .base) {
        self.content = content
        self.lineHeight = style.rawValue
    }

    public static func  compress(_ content: String) -> ParagraphView {
        ParagraphView(content, style: .compress)
    }

    public static func  large(_ content: String) -> ParagraphView {
        ParagraphView(content, style: .large)
    }

     public var body: some View {
        HStack{
            Text(content).fontSize(14).lineSpacing(self.lineHeight.toFloat())
            Spacer(minLength: 0)
        }.padding(.horizontal).padding(.vertical, self.lineHeight.toFloat())
    }
}

public enum LineSize: Int {
    case compress = 10
    case base = 16
    case large = 20
}