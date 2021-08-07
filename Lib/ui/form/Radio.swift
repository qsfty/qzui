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
struct RadioButton: View {

    @Binding var value: Bool
    var action: (Bool) -> Void

    var body: some View {
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

struct RadioButtonView: View {

    var value: Bool

    var body: some View {
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


struct RadioFillNumberButton: View {

    @Binding var value: Int

    @State var size: CGFloat = 18

    var body: some View {

        ZStack{
            if(self.value == 0){
                Circle().stroke(self.value > 0 ? Color("button0") : Color.white, lineWidth: 4)
                        .frame(width: self.size + 2, height: self.size + 2).background(Color.gray.opacity(0.2))
                        .cornerRadius(self.size + 2)
            }
            else{
                Circle().foregroundColor(Color("button0")).frame(width: self.size + 4, height: self.size + 4)
            }

            Text(self.value > 0 ? "\(self.value)" : "").font(.system(size: 14)).bold()
                    .foregroundColor(Color.white)
        }


    }
}

