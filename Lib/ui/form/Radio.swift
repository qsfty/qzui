//
//  Radio.swift
//  yuque
//
//  Created by 强子 on 2020/11/26.
//

import SwiftUI


/**
 * 输入框
 */
public struct RadioButton: View {

    @Binding var value: Bool
    var action: (Bool) -> Void

    public var body: some View {
        Group{
            if value {
                Image(systemName: "checkmark.circle").themeColor().emptyBg().onTapGesture {
                    self.value = !self.value
                    self.action(value)
                }
            } else {
                Image(systemName: "circle").foregroundColor(Color.gray.opacity(0.1)).emptyBg().onTapGesture {
                    self.value = !self.value
                    self.action(value)
                }
            }
        }
    }
}

public struct RadioButtonView: View {

    var value: Bool

    public init(value: Bool) {
        self.value = value
    }

    public var body: some View {
        Group{
            if value {
                Image(systemName: "checkmark.circle").themeColor()
            } else {
                Image(systemName: "circle").foregroundColor(Color.gray.opacity(0.1))
            }
        }.onChange(of: value){ v in
        }
    }
}


public struct RadioFillNumberButton: View {

    @Binding var value: Int

    @State var size: CGFloat = 18

    public var body: some View {

        ZStack{
            if(self.value == 0){
                Circle().stroke(self.value > 0 ? Color.theme : Color.white, lineWidth: 4)
                        .frame(width: self.size + 2, height: self.size + 2).background(Color.gray.opacity(0.2))
                        .cornerRadius(self.size + 2)
            }
            else{
                Circle().foregroundColor(Color.theme).frame(width: self.size + 4, height: self.size + 4)
            }

            Text(self.value > 0 ? "\(self.value)" : "").font(.system(size: 14)).bold()
                    .foregroundColor(Color.white)
        }


    }
}

