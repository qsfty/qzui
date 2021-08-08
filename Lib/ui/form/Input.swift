//
// Created by 强子 on 2021/8/7.
//

import SwiftUI

/**
 * 输入框
 */
public struct Input: View {

    public var label: String
    @Binding var value: String
    @State var focused: Bool = false
    var onCommit:() -> Void

    public var body: some View {
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

public struct SearchInput: View {

    public var label: String
    public var width: CGFloat = MyUIUtil.fullWidth() - 60
    @Binding public var value: String
    @Binding public var focus: Bool
    public var action: (String) -> ()

    public var body: some View {
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

