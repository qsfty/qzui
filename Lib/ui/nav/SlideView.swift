//
// Created by 强子 on 2021/8/7.
//
import SwiftUI
import QzLib

/**
 * 左滑
 */
public struct SlideDeleteRow<Content:View>: View {

    var content: Content

    @State var scrollX: CGFloat = 0
    @State var beginX: CGFloat = 0

    var sizeW:CGFloat = 160
    var id: String
    @Binding var activeId: String
    @GestureState var isDragging = false

    @State var isDelete:Bool = false

    var onDelete: () -> Void

    public init(id: String, activeId: Binding<String>, onDelete:@escaping () -> Void, @ViewBuilder content: () -> Content){
        self.id = id
        self._activeId = activeId
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

            if(!isDelete){
                HStack(spacing: 0){
                    Text("删除").fontSize(12).opacity(showText() ? 1 : 0).color(Color.white).width(sliderWidth()).maxHeight().bg(Color.red).animate().tap{
                        self.isDelete = true
                    }
                }.frame(width: -self.scrollX).maxHeight()
            }
            else{
                HStack(spacing: 0){
                    Text("确认删除").fontSize(12).opacity(showText() ? 1 : 0).color(Color.white).width(min(sizeW, scrollX.toAbs().toFloat())).maxHeight().bg(Color.red).tap{
                        self.onDelete()
                    }
                }.frame(width: -self.scrollX).maxHeight()
            }

            content.zIndex(101).offset(x: scrollX).highPriorityGesture(DragGesture(minimumDistance: 20, coordinateSpace: .local)
                    .onChanged{ value in
                        let gapX = value.translation.width
                        let gapY = value.translation.height

                        let absX = gapX.toAbs()
                        let absY = gapY.toAbs()

                        let newX = self.beginX + gapX
                        if(newX < 0 && newX > -MyUIUtil.fullWidth() * 2 / 3 && absX > 20){
                            MyTimerUtil.async {
                                self.activeId = self.id
                                self.scrollX = newX
                            }
                        }
                    }
                    .onEnded{ value in

                        if(self.scrollX.toAbs() < 50){
                            self.hide()
                        }
                        else{
                            self.show()
                        }
                    }).animate()
        }
    }

    func sliderWidth() -> CGFloat{
        return self.scrollX.toAbs().toFloat() / 2
    }

    func showText() -> Bool {
        return self.scrollX.toAbs().toFloat() / 2 > 40
    }

    func showText2() -> Bool {
        return self.scrollX.toAbs().toFloat() / 2 > 60
    }

    func hide(){
        MyTimerUtil.async {
            self.scrollX = 0
            self.beginX = 0
            self.isDelete = false
            self.activeId = "-1"
        }
    }
    func show(){
        MyTimerUtil.async {
            self.scrollX = -sizeW
            self.beginX = -sizeW
        }
    }
}
