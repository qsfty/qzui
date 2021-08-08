//
// Created by 强子 on 2021/2/26.
//


import SwiftUI


/**
 * 开关组件
 */
public struct SwitchButton : View {

    @Binding var value: Bool

    @State var x: CGFloat = 0
     public var body: some View {

        let circleWidth:CGFloat = 20
        let wrapperWidth:CGFloat = circleWidth * 2
        let wrapperHeight:CGFloat = circleWidth + 4
        let invalidPadding:CGFloat = 2
        let validPadding:CGFloat = wrapperWidth - 2 - circleWidth

        return ZStack(alignment: .leading) {
            Rectangle().width(wrapperWidth).height(wrapperHeight).foregroundColor(self.value ? Color("switchValidBg") : Color("switchInvalidBg")).cornerRadius(wrapperHeight / 2)
            Circle().width(circleWidth).foregroundColor(Color("switchCircleBg")).zIndex(10).offset(x: x)
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
            Circle().width(circleWidth).foregroundColor(Color("switchCircleBg")).zIndex(10).offset(x: x)
        }.emptyBg().tap0{
            MyTimerUtil.animation2{
                self.x = !self.value ? validPadding : invalidPadding
                self.action()
            }
        }.onAppear{
            self.x = self.value ? validPadding : invalidPadding
        }

    }
}
