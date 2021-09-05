//
// Created by 强子 on 2021/8/7.
//


import SwiftUI
import QzLib

public struct TipView : View {

    var tip: String
    var always: Bool = false
    var padding: Int = 15
    var top: Bool = true

    @State var show: Bool = false

    public init(tip: String, always: Bool = false, padding: Int = 15, top: Bool = true) {
        self.tip = tip
        self.always = always
        self.padding = padding
        self.top = top
    }

    public static func  new(_ tip: String, top: Bool = true) -> TipView {
        TipView(tip: tip, top: top)
    }

    public static func  new2(_ tip: String, top: Bool = true) -> TipView {
        TipView(tip: tip, padding: 15, top: top)
    }

    public static func  tip(_ tip: String, top: Bool = true) -> TipView {
        TipView(tip: tip, always: true, top: top)
    }

    public static func  tip2(_ tip: String, top: Bool = true) -> TipView {
        TipView(tip: tip, always: true, padding: 15, top: top)
    }


     public var body: some View {

        HStack(alignment: .top, spacing: 0) {
            if(show){
                Image(systemName: "info.circle").font(.system(size: 12)).color(Color.gray.opacity(0.5)).padding(.trailing, 5)
                Text(self.tip).fontSize(12).hint().lineLimit(8)
            }
            Spacer()
        }.padding(.top, self.show && top ? 10 : 0).onAppear{
            self.show = always || RegistCache.getRegistDay() < 3
        }.padding(.horizontal, padding.toFloat())

    }
}
