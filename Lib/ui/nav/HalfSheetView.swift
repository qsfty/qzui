//
// Created by 强子 on 2021/8/7.
//

//
// Created by 强子 on 2021/3/27.
//


import SwiftUI

/**
 * 半屏弹窗
 */
struct HalfSheetView<Content: View>: View {

    @Binding var shown: Bool

    @State var moveOffset: CGFloat = 0
    @GestureState var dragState: Bool = false

    @State var lastOffset: CGFloat = 0
    //是否需要确定按钮
    var title: String = ""

    var height: CGFloat = 0.6

    var action: (Bool) -> Void
    var content: Content

    var rightText: String = ""
    var rightAction: (() -> Void)? = nil

    var cancel: (() -> Void)? = nil
    @State var end: Bool = false

    init(title: String = "",shown: Binding<Bool>, height: CGFloat = 300, rightText: String = "", rightAction: (() -> Void)? = nil, action:@escaping (Bool) -> Void, cancel: (() -> Void)? = nil,  content: () -> Content){
        self.title = title
        self.height = height
        self._shown = shown
        self.action = action
        self.rightText = rightText
        self.rightAction = rightAction
        self.cancel = cancel
        self.content = content()
    }

    var body: some View {
        return VStack{
            ZStack(alignment: .top){
                LayerView(shown: $shown) {
                    UIApplication.shared.endEditing()
                    self.cancel?()
                }
                VStack(spacing:0){
                    HStack{
                        if(title != ""){
                            Text(title).bold()
                        }
                        Spacer()
                        if(title == ""){
                            Rectangle().width(26).height(4).cornerRadius(2).third()
                            Spacer()
                        }
                        if(rightText != ""){
                            Text(rightText).color(Color.blue).emptyBg().highTap{
                                self.rightAction?()
                            }
                        }
                    }.frame(maxWidth: 600).padding(.horizontal, 20)
                            .padding(.vertical, 20)
                            .mainBg()
                            .simultaneousGesture(DragGesture(minimumDistance: 0).onChanged{value in
                                if(value.translation.height > 0){
                                    MyTimerUtil.async {
                                        self.moveOffset = value.translation.height * 2
                                        self.lastOffset = self.moveOffset
                                    }
                                }
                            }.onEnded{ value in
                                MyTimerUtil.async {
                                    if(self.lastOffset > 50){
                                        MyTimerUtil.animation{
                                            self.shown.toggle()
                                        }
                                        MyTimerUtil.async {
                                            self.moveOffset = 0
                                            self.lastOffset = 0
                                        }
                                    }
                                    else{
                                        self.moveOffset = 0
                                        self.lastOffset = 0
                                    }
                                }
                            })
                    ScrollView{
                        content
                    }.padding(.bottom, MyUIUtil.getTabbarHeight())
                    Spacer()
                }
                        .mainBg().cornerRadius(10).offset(y: self.shown ? (restDialogHeight() + self.moveOffset) : MyUIUtil.fullHeight())
                        .animate().zIndex(100)
            }
        }
                .zIndex(self.shown ? 100 : -100)

    }

    func dialogHeight() -> CGFloat{
        self.height
    }

    func restDialogHeight() -> CGFloat{
        MyUIUtil.fullHeight() - self.height
    }
}


struct LayerView: View {

    @Binding var shown: Bool
    var action: (() -> Void)?

    var body: some View {
        Group{
            if(shown){
                Color.gray.opacity(0.2).zIndex(10).edgesIgnoringSafeArea(.all).tap0{
                    self.shown.toggle()
                    self.action?()
                }
            }
            else{
                Color.clear.height(1)
            }
        }
    }

}