//
//  Radio.swift
//  yuque
//
//  Created by 强子 on 2020/11/26.
//

import SwiftUI
import QzLib


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
                Image(systemName: "circle").font(.system(size: 14, weight: .medium)).foregroundColor(Color.gray.opacity(0.5))
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


public struct RadioSelectButton: View {

    var label: String
    var value: String
    @Binding var selectValue: String

    public init(label: String, value: String, selectValue: Binding<String>) {
        self.label = label
        self.value = value
        self._selectValue = selectValue
    }

    public var body: some View {
        Text(self.label).padding().mainBg().cornerRadius(6).selected(flag: value == self.selectValue).tap{
            self.selectValue = value
        }
    }

}

public struct VipLogo: View {

    public var body: some View {
        Image(systemName: "crown").resizable().fontSize(6).color(Color.white).padding(2).width(14).height(14).background(parseHexColor("#F7D17C"))
                .cornerRadius(7)
    }

}

public struct RadioPanelButton: View {

    var label: String
    var value: String
    var crown: Bool
    @Binding var selectValue: String

    public init(label: String, value: String,crown: Bool = false, selectValue: Binding<String>) {
        self.label = label
        self.value = value
        self.crown = crown
        self._selectValue = selectValue
    }

    public var body: some View {
        HStack(spacing: 2){
            if(crown){
                VipLogo()
            }
            Text(self.label).fontSize(12)
        }.padding(6).mainBg().cornerRadius(6)
                .selected2(flag: value == self.selectValue).tap{
                    self.selectValue = value
                }

    }

}

extension View {

    public func selected(flag: Bool) -> some View{
        self.border(color: flag ? Color.theme : Color.mainBg, radius: 6, lineWidth: 2).padding(2).overlay(ZStack(alignment: .bottomTrailing){
            if(flag){
                Color.clear
                Text("选").fontSize(10).padding(2).theme().cornerRadius(2)
                .offset(x: -2, y: -2)

            }
            else{
                Color.clear
            }
        })
    }

    public func selected2(flag: Bool) -> some View{
        self.border(color: flag ? Color.theme : Color.mainBg, radius: 6, lineWidth: 2).padding(2)
    }
}