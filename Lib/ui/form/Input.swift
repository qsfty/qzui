//
// Created by 强子 on 2021/8/7.
//

import SwiftUI

/**
 * 输入框
 */
struct Input: View {

    var label: String
    @Binding var value: String
    @State var focused: Bool = false
    var onCommit:() -> Void

    var body: some View {
        ZStack(alignment: Alignment.trailing) {
            TextField(label, text: $value, onEditingChanged: { (editingChanged) in
                self.focused = editingChanged
            }, onCommit: onCommit).font(.system(size: 14)).frame(width:MyUIUtil.fullWidth() - 80,height: 20).padding(5).mainBg().cornerRadius(6)

            if(self.focused && self.value != ""){
                Image(systemName: "xmark.circle.fill").foregroundColor(Color.gray).padding(.trailing, 5).onTapGesture {
                    self.value = ""
                }.mainBg()
            }
        }
    }
}

struct SearchInput: View {

    var label: String
    var width: CGFloat = MyUIUtil.fullWidth() - 60
    @Binding var value: String
    @Binding var focus: Bool
    var action: (String) -> ()


    var body: some View {
        ZStack(alignment: Alignment.trailing) {

            TextField(label, text: $value, onEditingChanged: { (editingChanged) in
                self.focus = editingChanged
            }, onCommit: {
                action(self.value)
            }).font(.system(size: 14)).frame(width:self.width,height: 20).padding(10).mainBg().cornerRadius(6)

            Image(systemName: "magnifyingglass").foregroundColor(Color.gray).padding(.all, 10).onTapGesture {
                action(self.value)
            }
        }
    }
}

