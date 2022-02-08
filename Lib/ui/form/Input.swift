//
// Created by 强子 on 2021/8/7.
//

import SwiftUI

/**
 * 输入框
 */
public struct Input: View {

    public var label: String
    @Binding public var value: String

    public init(label: String, value: Binding<String>) {
        self.label = label
        self._value = value
    }

    public var body: some View {
        TextField(label, text: $value).font(.system(size: 14)).maxWidth().padding().mainBg().cornerRadius(6)
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

public struct BigSearchInputView: View {

    public var hint: String
    @Binding var value: String
    public var action: () -> ()

    public init(hint: String, value: Binding<String>, action: @escaping () -> ()) {
        self.hint = hint
        self._value = value
        self.action = action
    }

    public var body: some View {
        ZStack {
            TextField(hint, text: $value){
                action()
            }.multilineTextAlignment(.center)
                    .fontSize(14).padding().maxWidth().mainBg().cornerRadius(6).padding()
        }
    }
}

