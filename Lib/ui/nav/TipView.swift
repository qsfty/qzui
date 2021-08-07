//
// Created by 强子 on 2021/8/7.
//


import SwiftUI

struct TipView : View {

    var tip: String
    var always: Bool = false
    var padding: Int = 15
    var top: Bool = true

    @State var show: Bool = false

    static func new(_ tip: String, top: Bool = true) -> TipView {
        TipView(tip: tip, top: top)
    }

    static func new2(_ tip: String, top: Bool = true) -> TipView {
        TipView(tip: tip, padding: 15, top: top)
    }

    static func tip(_ tip: String, top: Bool = true) -> TipView {
        TipView(tip: tip, always: true, top: top)
    }

    static func tip2(_ tip: String, top: Bool = true) -> TipView {
        TipView(tip: tip, always: true, padding: 15, top: top)
    }


    var body: some View {

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