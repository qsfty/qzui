//
// Created by 强子 on 2021/8/7.
//


import SwiftUI
import QzLib

public struct TipView : View {

    var always: Bool = false
    var padding: CGFloat = 15
    var top: Bool = true
    var bottom: Bool = false
    var tips: [String] = []

    @State var show: Bool = false

    public init(tip: String, always: Bool = false, padding: CGFloat = 15, top: Bool = true, bottom: Bool = false, tips: [String] = []) {
        self.always = always
        self.padding = padding
        self.top = top
        self.bottom = bottom
        if(tips.isEmpty){
            self.tips = [tip]
        }
        else{
            self.tips = tips
        }
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

    public static func tips(_ tips: [String],padding: CGFloat = 15, top: Bool = false, bottom: Bool = true) -> TipView {
        TipView(tip: "", always: true, padding: padding, top: top, tips: tips)
    }

     public var body: some View {

        HStack(alignment: .top, spacing: 0) {
            if(show){
                VStack(spacing:3){
                    ForEach(self.tips.indices) {i in
                        HStack(alignment: .top, spacing: 2){
                            Image(systemName: "info.circle").font(.system(size: 12)).color(Color.gray.opacity(0.5))
                            Text(self.tips[i]).fontSize(12).hint().lineLimit(8)
                                    .fixedSize(horizontal: false, vertical: true)
                            Spacer()
                        }
                    }
                }
            }
            Spacer()
        }.padding(.top, self.show && top ? 10 : 0).onAppear{
            self.show = always || RegistCache.getRegistDay() < 3
        }
                .padding(.horizontal, padding)
         .padding(.bottom, show && bottom ? 10 : 0)


    }
}
