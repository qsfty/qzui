//
// Created by 强子 on 2021/5/2.
//

import SwiftUI
import QzLib

public struct GroupView<Content: View>: View {

    public var spacing: CGFloat
    public var content: Content


    public init(spacing: CGFloat = 0, @ViewBuilder content:@escaping () -> Content) {
        self.spacing = spacing
        self.content = content()
    }

    public var body: some View {
        VStack(spacing:spacing){
            content
        }.padding(.vertical, spacing).mainBg().cornerRadius(8).padding(.horizontal, 15)

    }
}


public struct Triangle: Shape {

    var size: CGFloat = 10

    public init(){
        self.size = 30
    }

    public init(_ size: CGFloat){
        self.size = size
    }

    public func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: size, y: 0))
            path.addLine(to: CGPoint(x: 0, y: size))
            path.closeSubpath()
        }
    }
}


public struct BlockView: View {

    public var label: String
    public var alignment: Alignment
    public var color: Color

    public init(label: String, alignment: Alignment = .center, color: Color = .gray) {
        self.label = label
        self.alignment = alignment
        self.color = color
    }

    public var body: some View {
        GroupView{
            HStack{
                if(alignment == Alignment.center){
                    Spacer()
                }
                Text(label).fontSize(12).color(color)
                Spacer()
            }.padding().mainBg()
        }
    }

    public static func warn(_ label: String) -> BlockView {
        BlockView(label: label, alignment: .leading, color: .delete)
    }

    public static func info(_ label: String, color: Color = Color.second) -> BlockView {
        BlockView(label: label, alignment: .leading, color: color)
    }
}

public struct CornerGroup<Content: View>: View {

    public var content: Content

    public init(@ViewBuilder content:@escaping () -> Content) {
        self.content = content()
    }

    public var body: some View {
        VStack(spacing:0){
            content
        }.cornerRadius(8)
    }
}

public struct GroupFormView<Content: View>: View {

    public var cancel: () -> Void
    public var ok: () -> Void
    public var content: Content

    public init(cancel: @escaping () -> (), ok: @escaping () -> (), @ViewBuilder content:@escaping () -> Content) {
        self.cancel = cancel
        self.ok = ok
        self.content = content()
    }

    public var body: some View {
        VStack{
            content

            HStack{
                CancelButton{
                    cancel()
                }
                OkButton{
                    ok()
                }
            }.padding()
        }.mainBg().cornerRadius(8).padding(.horizontal)
    }

}
