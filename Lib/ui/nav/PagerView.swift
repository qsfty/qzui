//
// Created by 强子 on 2021/8/7.
//

import SwiftUI

/**
 * 滑动组件
 */
struct PagerView<Content:View>: View {

    var pages: Int
    @Binding var currentPage: Int
    var width: CGFloat = MyUIUtil.fullWidth()
    var content: Content

    var onPageChanged: ((Int) -> Void)? = nil

    @State var inited = false

    @State var scrollX: CGFloat = 0
    @GestureState var isDragging = false

    init(pages: Int, currentPage: Binding<Int>,onPageChanged: ((Int) -> Void)? = nil, @ViewBuilder content: () -> Content) {
        self.pages = pages
        self._currentPage = currentPage
        self.onPageChanged = onPageChanged
        self.content = content()

//        self.scrollX = -self.currentPage.toFloat() * self.width
    }

    var body: some View {
        HStack(alignment: .top, spacing:0){
            self.content
        }.offset(x: (pages - 1).toFloat() * self.width / 2)
                .simultaneousGesture(DragGesture(minimumDistance: 20).updating($isDragging){ (value, state, _) in
                            state = true
                        }
                        .onChanged{ value in
                            let gapX = value.translation.width.toAbs()
                            let gapY = value.translation.height.toAbs()
                            if(gapX > 30 && (gapY == 0 || gapX / gapY > 2)){
                                DispatchQueue.main.async {
                                    self.scrollX = value.translation.width - self.currentPage.toFloat() * self.width
                                }
//                                state = true
                            }
                            else{
//                                state = false
                            }
                        }
                        .onEnded { value in
                            let gap = value.translation.width
                            let flag = gap > 0 ? -1 : 1
                            let nextPage = self.currentPage + flag
                            //偏移量小于30
                            let gapX = gap.toAbs()
                            let gapLess30 = gapX < 30
                            //已经在首页或最后一页
                            let inEdgePage = nextPage < 0 || nextPage >= self.pages
                            if(!(gapLess30 || inEdgePage)){
                                self.currentPage = nextPage
                                onPageChanged?(nextPage)
                            }
                            self.scrollX = -self.currentPage.toFloat() * self.width
                        }).animation(inited ? .linear(duration: 0.2) : nil)
                .offset(x: self.isDragging ? self.scrollX: -self.currentPage.toFloat() * self.width)
                .onAppear{
                    MyTimerUtil.sleep1 {
                        self.inited = true
                    }
                }
    }

}

