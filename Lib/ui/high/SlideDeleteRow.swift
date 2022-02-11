//
// Created by 强子 on 2021/10/2.
//


import SwiftUI
import QzLib

//左滑
public struct SlideDeleteRow<Content:View>: View {

    var content: Content

    @State var scrollX: CGFloat = 0
    @State var beginX: CGFloat = 0

    var sizeW:CGFloat = 60
    var id: String
    @Binding var activeId: String
    @GestureState var isDragging = false

    @State var isDelete:Bool = false

    var showAlert: () -> Bool
    var onDelete: () -> Void

    public init(id: String, activeId: Binding<String>,showAlert:@escaping () -> Bool, onDelete:@escaping () -> Void, @ViewBuilder content: () -> Content){
        self.id = id
        self._activeId = activeId
        self.onDelete = onDelete
        self.showAlert = showAlert
        self.content = content()
    }

    public var body: some View {


        if(self.beginX != 0 && self.id != self.activeId){
            MyTimerUtil.async {
                self.hide()
            }
        }

        return ZStack(alignment: .trailing){

            HStack{
                Text(getDeleteText()).fontSize(12).color(Color.white)
            }.maxHeight().width(-self.scrollX).background(Color.delete).tap {
                if(isDelete){
                    self.onDelete()
                }
                else{
                    if(self.showAlert()){
                        self.isDelete = true
                    }
                    else{
                        self.onDelete()
                    }
                }
            }

            content.zIndex(101).offset(x: scrollX).highPriorityGesture(DragGesture(minimumDistance: 20, coordinateSpace: .local).updating($isDragging) { (value, state, _) in
                        state = true
                        let gapX = value.translation.width
                        let gapY = value.translation.height

                        let absX = gapX.toAbs()
                        let absY = gapY.toAbs()

                        if(absX > 10 && (absY == 0 || absX / absY > 2)){
                            let newX = self.beginX + gapX
                            if(newX < 0 && newX > -MyUIUtil.fullWidth() * 2 / 3){
                                MyTimerUtil.async {
                                    self.activeId = self.id
                                    MyTimerUtil.animation2 {
                                        self.scrollX = newX
                                    }
                                }
                            }
                        }
                    }

                    .onEnded{ value in

                        if(self.scrollX.toAbs() < 50){
                            self.hide()
                        }
                        else{
                            if(self.beginX < 0){
                                self.hide()
                            }
                            else{
                                self.show()
                            }
                        }
                    })
        }
    }


    func getDeleteText() -> String {
        if(scrollX.toAbs() < 30){
            return ""
        }
        return isDelete ? "确任\n删除" : "删除"
    }

    func hide(){
        MyTimerUtil.async {
            MyTimerUtil.animation2 {
                self.scrollX = 0
                self.beginX = 0
                self.isDelete = false
                self.activeId = "-1"
            }
        }

    }
    func show(){
        MyTimerUtil.async {
            MyTimerUtil.animation2 {
                self.scrollX = -sizeW
                self.beginX = -sizeW
            }
        }
    }
}