
//
// Created by 强子 on 2021/5/1.
//


import SwiftUI

public struct OkButton: View {


    public var label: String = "确认"
    public var loading: Bool = false

    public var action: () -> Void

    public var body: some View {
        Text(label).fontSize(14).width(80).height(32)
                .tap(radius: 20, action: action)
    }

}

public struct CancelButton: View {

    public var label: String = "取消"
    public var action: () -> Void

    public var body: some View {
        Text(label).fontSize(14).width(80).height(32)
                .cornerRadius(20)
                .tap(radius: 20, action: action)
    }

}

public struct LongOkButton: View {

    public var label: String = "确定"
    public var horizontalPadding: CGFloat = 15
    public var verticalPadding: CGFloat = 5
    public var action: () -> Void

    public var body: some View {

        Text(label).fontSize(14)
                .width(MyUIUtil.fullWidth() - horizontalPadding * 2)
                .height(40)
                .themeBg().color(Color.white)
                .cornerRadius(6).tap(radius: 6, action: action)
                .padding(.vertical, verticalPadding)

    }
}


public struct LongCancelButton: View {

    public var padding: CGFloat = 15
    public var action: () -> Void

    public var body: some View {

        Text("取消").fontSize(14)
                .width(MyUIUtil.fullWidth() - padding * 2)
                .height(40)
                .mainBg().color(Color.primary)
                .cornerRadius(6).tap(radius: 6, action: action)
    }
}