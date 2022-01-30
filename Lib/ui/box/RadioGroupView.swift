//
// Created by 强子 on 2021/11/13.
//
import SwiftUI
import QzLib
public struct RadioGroupView: View {

    var options: [SelectDO]

    @Binding var value: String
    @State var columns: [GridItem] = [GridItem(), GridItem(), GridItem(), GridItem()]

    public init(options: [SelectDO], value: Binding<String>) {
        self.options = options
        self._value = value
    }

    @State var realGap:CGFloat = 8

    public var body: some View {
        LazyVGrid(columns: columns, spacing: realGap){
            ForEach(options, id: \.value){item in
                Text(item.label).color(item.value == value ? .theme : Color.primary).fontSize(13).width(40).height(26).mainBg().cornerRadius(4).tap{
                    self.value = item.value
                }
            }
        }.padding(.horizontal).onAppear{
            //初始化grids
            let w:CGFloat = 40
            let gap: CGFloat = 5
            let size = (MyUIUtil.fullWidth() - 30 + gap) / (gap + w)
            self.columns = []
            for i in 0..<size.toInt() {
                self.columns.append(GridItem())
            }
            self.realGap = (MyUIUtil.fullWidth() - 30 - size * w) / (size - 1)
            ps("gap", self.realGap)
        }
    }

}