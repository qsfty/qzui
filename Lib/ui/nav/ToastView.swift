//
// Created by 强子 on 2021/8/7.
//

import SwiftUI

public struct ToastView: View {

    var sheet: Bool = false
    @Binding var toastInfo: ToastDO

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
                    .cornerRadius(20)
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
