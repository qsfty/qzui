//
// Created by 强子 on 2021/8/7.
//

import SwiftUI

public struct TitleView: View {

    var title: String

    init(_ title: String){
        self.title = title
    }

     public var body: some View {
        HStack{
            Spacer()
            Text(self.title).foregroundColor(Color("primary"))
            Spacer()
        }.padding().padding(.bottom,20)
    }
}


public struct LeadingTitleView: View {

    var title: String

    init(_ title: String){
        self.title = title
    }

     public var body: some View {
        HStack{
            Text(self.title).bold().fontSize(16).primary()
            Spacer()
        }.padding().padding(.bottom,10)
    }
}


public struct LeadingTextView: View {

    var title: String
    var fontSize: CGFloat = 14
    var color: Color = Color.primary
    var bold: Bool = false

    public init(title: String, fontSize: CGFloat = 14, color: Color = Color.primary, bold: Bool = false) {
        self.title = title
        self.fontSize = fontSize
        self.color = color
        self.bold = bold
    }

    public var body: some View {
        HStack{
            Text(self.title).fontWeight(bold ? .bold : .none).fontSize(fontSize).color(color)
            Spacer()
        }.padding(.horizontal)
    }
}
