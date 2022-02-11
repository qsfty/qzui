//
// Created by 强子 on 2020/12/26.
//


import SwiftUI
import QzLib
import QzUI

//左滑
public struct SlideEditRow<Content:View>: View {

    var content: Content

    @State var scrollX: CGFloat = 0
    @State var beginX: CGFloat = 0

    var sizeW:CGFloat = 160
    var id: String
    @Binding var activeId: String
    @GestureState var isDragging = false

    @State var isDelete:Bool = false

    var onCopy: () -> Void
    var canDelete: (() -> Bool)?
    var onDelete: () -> Void

    public init(id: String, activeId: Binding<String>,onCopy:@escaping () -> Void,canDelete: (() -> Bool)? = nil, onDelete:@escaping () -> Void, @ViewBuilder content: () -> Content){
        self.id = id
        self._activeId = activeId
        self.onCopy = onCopy
        self.canDelete = canDelete
        self.onDelete = onDelete
        self.content = content()
    }

    public var body: some View {


        if(self.beginX != 0 && self.id != self.activeId){
            MyTimerUtil.async {
                self.hide()
            }
        }

        return ZStack(alignment: .trailing){

            HStack(spacing: 0){
                Text(getEditText()).fontSize(12).width(getEditWidth()).maxHeight().color(.blue).bg(Color.blue.opacity(0.1)).tap{
                    self.onCopy()
                }
                Text(getDeleteText()).fontSize(12).width(getDeleteWidth()).maxHeight().color(.delete).bg(Color.delete.opacity(0.1)).tap{
                    if(!(self.canDelete?() ?? true)){
                        return
                    }
                    if(self.isDelete){
                        self.onDelete()
                    }
                    else{
                        self.isDelete = true
                    }
                }
            }.cornerRadius(6).frame(width: -self.scrollX).offset(x: 2)

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
        let w = getDeleteWidth()
        if(isDelete){
            if(w < 60){
                return ""
            }
        }
        else{
            if(w < 30){
                return ""
            }
        }
        return isDelete ? "确任删除" : "删除"
    }

    func getDeleteWidth() -> CGFloat {
        if(isDelete){
            return self.scrollX.toAbs().toFloat()
        }
        return self.scrollX.toAbs().toFloat() / 2.toFloat()
    }


    func getEditText() -> String {
        if(getEditWidth() < 30){
            return ""
        }
        return isDelete ? "" : "编辑"
    }

    func getEditWidth() -> CGFloat {
        if(isDelete){
            return 0
        }
        return self.scrollX.toAbs().toFloat() / 2.toFloat()
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