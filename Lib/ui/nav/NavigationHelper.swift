//
// Created by 强子 on 2021/8/7.
//

//
// Created by 强子 on 2021/5/1.
//

import SwiftUI

/**
 * 没有数据
 */
struct EmptyView: View {

    var content: String
    var action: (() -> Void)? = nil

    var body: some View {

        VStack {
            Spacer()
            Text(content).multilineTextAlignment(.center).lineSpacing(5).font(.system(size: 14)).foregroundColor(Color.gray).padding().fullWidth()
            Spacer()
        }.padding().tap0{
            self.action?()
        }
    }
}

struct EmptyLineView: View {

    var content: String
    var action: (() -> Void)? = nil

    var body: some View {

        HStack {
            Spacer()
            Text(content).hint()
            Spacer()
        }.padding().mainBg().cornerRadius(6).tap0{
            self.action?()
        }
    }
}


struct EmptyLinkView<Destination: View>: View {

    var destination: Destination

    @Binding var isActive: Bool

    var body: some View {

        NavigationLink(destination: destination, isActive: $isActive){
            Text("")
        }.height(0).width(0)
    }
}



struct BugFillLinkView: View {
    var body: some View {
        NavigationLink(destination: Text("")){
            Text("")
        }.height(0).width(0)
    }
}