//
// Created by 强子 on 2021/8/7.
//

import SwiftUI


/**
 * 横向加载进度条
 */
public struct LoadingBarView: View{

    var width: CGFloat = MyUIUtil.fullWidth()
    @Binding var loading: Bool
    @State var loadingWidth: CGFloat = 0
    @State var loadingStep: CGFloat = 30


    func initView(){
        self.loadingWidth = 0
        self.loading = true
        self.loadingStep = 30
        onPageAppear()
    }

     public var body: some View {
        HStack(spacing:0){
            Rectangle().frame(width: self.loadingWidth, height: 3).animation(self.loading ? .linear: nil).foregroundColor(self.loadingWidth > 0 ? Color.theme : Color.clear)
            Spacer(minLength: 0)
        }.frame(width: self.width).onAppear{
            onPageAppear()
        }.onChange(of: loading, perform: { value in

            if(loading){
                initView()
            }
            else{
                MyTimerUtil.async {
                    self.loadingWidth = self.width
                    MyTimerUtil.after {
                        self.loadingWidth = 0
                    }
                }

            }

        })
    }

    func onPageAppear(){
        MyRequestUtil.judgeNetwork{ ok in
            if(!ok) {
                self.loading = false
            }
            else{
                MyTimerUtil.schedule(0.1) { timer in
                    if(!self.loading){
                        timer.invalidate()
                        return
                    }

                    let W = self.width
                    if(self.loadingWidth > W){
                        timer.invalidate()
                    }
                    var w = self.loadingWidth + self.loadingStep
                    if(w > W * 0.98){
                        MyRequestUtil.judgeNetwork{ ok in
                            if(!ok) {
                                timer.invalidate()
                                self.loading = false
                            }
                        }
                        w = W * 0.98
                        self.loadingStep = 0.1
                    }
                    else if(w > W * 0.8) {
                        self.loadingStep = 2
                    }
                    else if(w > W * 0.618) {
                        self.loadingStep = 10
                    }
                    self.loadingWidth = w

                }
            }
        }
    }

}
