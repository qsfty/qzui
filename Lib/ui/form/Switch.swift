//
// Created by 强子 on 2021/2/26.
//


import SwiftUI
import QzLib

/**
 * 开关组件
 */
public struct SwitchButton : View {

    @Binding var value: Bool

    @State var x: CGFloat = 0
     public var body: some View {

        let circleWidth:CGFloat = 15
        let wrapperWidth:CGFloat = circleWidth * 2
        let wrapperHeight:CGFloat = circleWidth + 4
        let invalidPadding:CGFloat = 2
        let validPadding:CGFloat = wrapperWidth - 2 - circleWidth

        return ZStack(alignment: .leading) {
            Rectangle().width(wrapperWidth).height(wrapperHeight).foregroundColor(self.value ? Color("switchValidBg") : Color("switchInvalidBg")).cornerRadius(wrapperHeight / 2)
            Circle().width(circleWidth).height(circleWidth).foregroundColor(Color("switchCircleBg")).zIndex(10).offset(x: x)
        }.emptyBg().tap0{
            self.value.toggle()
            MyTimerUtil.animation2{
                self.x = self.value ? validPadding : invalidPadding
            }
        }.onAppear{
            self.x = self.value ? validPadding : invalidPadding
        }
    }
}


public struct SwitchActionButton : View {

    var value: Bool
    var action: (() -> Void)
    @State var x: CGFloat = 0

     public var body: some View {

        let circleWidth:CGFloat = 20
        let wrapperWidth:CGFloat = circleWidth * 2
        let wrapperHeight:CGFloat = circleWidth + 4
        let invalidPadding:CGFloat = 2
        let validPadding:CGFloat = wrapperWidth - 2 - circleWidth

        return ZStack(alignment: .leading) {
            Rectangle().width(wrapperWidth).height(wrapperHeight).foregroundColor(self.value ? Color("switchValidBg") : Color("switchInvalidBg")).cornerRadius(wrapperHeight / 2)
            Circle().width(circleWidth).height(circleWidth).foregroundColor(Color("switchCircleBg")).zIndex(10).offset(x: x)
        }.emptyBg().tap0{
            MyTimerUtil.animation2{
//                self.x = !self.value ? validPadding : invalidPadding
                self.action()
            }
        }.onAppear{
            self.x = self.value ? validPadding : invalidPadding
        }.onChange(of: value) { v in
            self.x =  v ? validPadding : invalidPadding
        }

    }
}

public struct SwitchChooseButton : View {

    @Binding var value: String
    var options: [SelectDO]
    @State var x: CGFloat = 0
    var contentWidth:CGFloat = 40
    var contentHeight:CGFloat = 26

    public init(value: Binding<String>, options: [SelectDO]) {
        self._value = value
        self.options = options
    }

    public var body: some View {
        return ZStack(alignment: .leading) {
            Color.gray.opacity(0.1).width(contentWidth * options.count.toFloat()).cornerRadius(4)
            Color.switchValidBg.width(contentWidth - 4).height(contentHeight - 6)
                    .cornerRadius(4)
            .offset(x: x)
            .zIndex(1)
            HStack(spacing:0){
                ForEach(Array(options.enumerated()), id: \.offset) { (index, item) in
                    Text(item.label).fontSize(10).color(focusColor(item)).width(contentWidth).height(contentHeight).tap{
                        self.value = item.value
                    }
                }
            }.zIndex(2)
        }.emptyBg().tap0{
            MyTimerUtil.animation2{
            }
        }.onAppear{
            self.move(self.value)
        }.onChange(of: value) { v in
            MyTimerUtil.animation2{
                self.move(v)
            }
        }
    }

    func move(_ value: String) {
        let vi = options.firstIndex{$0.value == self.value} ?? 0
        self.x = vi.toFloat() * contentWidth + 2
        self.value = options[vi].value
    }

    func focusColor(_ item: SelectDO) -> Color{
        if(item.value == self.value){
            return Color.white
        }
        return Color.gray
    }
}
