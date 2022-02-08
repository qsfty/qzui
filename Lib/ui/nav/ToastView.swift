//
// Created by 强子 on 2021/8/7.
//

import SwiftUI
import QzLib

public struct ToastView: View {

    public var sheet: Bool = false
    @Binding var toastInfo: ToastDO

    public init(sheet: Bool = false, toastInfo: Binding<ToastDO>) {
        self.sheet = sheet
        self._toastInfo = toastInfo
    }

     public var body: some View {

        if(!toastInfo.show){
            Color.clear.frame(width: 0,height: 0)
        }
        else if(toastInfo.sheet == self.sheet){
            Text(toastInfo.message)
                    .font(.system(size: 12))
                    .padding(10)
                    .padding(.horizontal, 20)
                    .background(Color(toastInfo.success ? "gray" : "error"))
                    .cornerRadius(6)
                    .foregroundColor(Color.white).onAppear{
                        MyTimerUtil.sleep(toastInfo.message.count < 8 ? 1 : 2) {
                            toastInfo.show.toggle()
                        }
                    }.offset(y: 120).zIndex(10)
        }
        else{
            Color.clear.frame(width: 0,height: 0)
        }
    }
}


public struct ToastLoading: View {

    public var sheet: Bool = false
    var loadingMessage: String = "加载中"

    public init(sheet: Bool = false, loadingMessage: String = "") {
        self.sheet = sheet
        if(loadingMessage != ""){
            self.loadingMessage = loadingMessage
        }
    }

    public var body: some View {
        Text(loadingMessage)
                .fontSize(12)
                .color(.white)
                .padding(10)
                .padding(.horizontal, 20)
                .background(Color("gray"))
                .cornerRadius(20)
                .offset(y: 120).zIndex(10)
    }
}