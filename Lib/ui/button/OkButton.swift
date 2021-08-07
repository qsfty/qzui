
//
// Created by 强子 on 2021/5/1.
//


import SwiftUI

struct OkButton: View {


    var label: String = "确认"
    var loading: Bool = false

    var action: () -> Void

    var body: some View {
        Text(label).fontSize(14).width(80).height(32)
                .tap(radius: 20, action: action)
    }

}

struct CancelButton: View {

    var label: String = "取消"
    var action: () -> Void

    var body: some View {
        Text(label).fontSize(14).width(80).height(32)
                .cornerRadius(20)
                .tap(radius: 20, action: action)
    }

}

struct LongOkButton: View {

    var label: String = "确定"
    var horizontalPadding: CGFloat = 15
    var verticalPadding: CGFloat = 5
    var action: () -> Void

    var body: some View {

        Text(label).fontSize(14)
                .width(MyUIUtil.fullWidth() - horizontalPadding * 2)
                .height(40)
                .themeBg().color(Color.white)
                .cornerRadius(6).tap(radius: 6, action: action)
                .padding(.vertical, verticalPadding)

    }
}


struct LongCancelButton: View {

    var padding: CGFloat = 15
    var action: () -> Void

    var body: some View {

        Text("取消").fontSize(14)
                .width(MyUIUtil.fullWidth() - padding * 2)
                .height(40)
                .mainBg().color(Color.primary)
                .cornerRadius(6).tap(radius: 6, action: action)
    }
}