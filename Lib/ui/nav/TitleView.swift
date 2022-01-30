//
// Created by 强子 on 2021/8/7.
//

import SwiftUI
import QzLib

public struct TitleView: View {

    var title: String

    public init(_ title: String) {
        self.title = title
    }

    public var body: some View {
        HStack {
            Spacer()
            Text(self.title).foregroundColor(Color("primary"))
            Spacer()
        }.padding().padding(.bottom, 20)
    }
}


public struct LeadingTextView: View {

    var title: String
    var fontSize: CGFloat = 14
    var color: Color = Color.primary
    var bold: Bool = false

    public init(_ title: String, fontSize: CGFloat = 14, color: Color = Color.primary, bold: Bool = false) {
        self.title = title
        self.fontSize = fontSize
        self.color = color
        self.bold = bold
    }

    public var body: some View {
        HStack {
            Text(self.title).fontWeight(bold ? .bold : .none).fontSize(fontSize).color(color)
            Spacer()
        }.padding(.vertical, 5).padding(.horizontal)
    }
}



public struct LeadingOpenTextView<Content: View>: View {

    var title: String
    var padding: CGFloat = 10
    var fontSize: CGFloat = 14
    var color: Color = Color.primary
    var bold: Bool = false
    @State var open = false
    var content: Content

    public init(_ title: String,padding: CGFloat = 10, fontSize: CGFloat = 14, color: Color = Color.primary, bold: Bool = false, @ViewBuilder content: () -> Content) {
        self.title = title
        self.padding = padding
        self.fontSize = fontSize
        self.color = color
        self.bold = bold
        self.content = content()
    }

    public var body: some View {
        VStack{
            HStack(alignment: .center) {
                Text(self.title).fontWeight(bold ? .bold : .none).fontSize(fontSize).color(color)
                Spacer()
                Image(systemName:"chevron.right").fontSize(14).rotationEffect(.degrees(open ? 90 : 0))
            }.padding(.vertical, padding).padding(.horizontal).emptyBg().onTapGesture{
                MyTimerUtil.animation2{
                    self.open.toggle()
                }
            }
            if(open){
                content
            }
        }

    }
}


public struct LeadingTextWithAddView: View {

    var title: String
    var fontSize: CGFloat = 14
    var color: Color = Color.primary
    var bold: Bool = false
    var action: () -> Void

    public init(_ title: String,
                fontSize: CGFloat = 14,
                color: Color = Color.primary,
                bold: Bool = false,
                action: @escaping () -> Void) {
        self.title = title
        self.fontSize = fontSize
        self.color = color
        self.bold = bold
        self.action = action
    }

    public var body: some View {
        HStack {
            Text(self.title).fontWeight(bold ? .bold : .none).fontSize(fontSize).color(color)
            Spacer()
            Image(systemName: "plus").fontSize(14).tap {
                self.action()
            }
        }.padding(.vertical, 5).padding(.horizontal)
    }
}


public struct LeadingHintTextView: View {

    var title: String
    var hint: String = ""
    var fontSize: CGFloat = 14
    var color: Color = Color.gray
    var bold: Bool = false

    public init(_ title: String,hint: String = "", fontSize: CGFloat = 14, color: Color = Color.gray, bold: Bool = false) {
        self.title = title
        if(hint != ""){
            self.hint = "(" + hint + ")"
        }
        self.fontSize = fontSize
        self.color = color
        self.bold = bold
    }

    public var body: some View {
        HStack {
            Text(self.title).fontWeight(bold ? .bold : .none).fontSize(fontSize).color(color)
            Text(self.hint).smallHint()
            Spacer()
        }.padding(.vertical, 5).padding(.horizontal)
    }
}
