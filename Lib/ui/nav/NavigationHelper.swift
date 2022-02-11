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
public struct EmptyDataView: View {

    var content: String
    var action: (() -> Void)? = nil

    public init(_ content: String, action: (() -> ())? = nil) {
        self.content = content
        self.action = action
    }

    public var body: some View {

        VStack {
            Spacer()
            Image(systemName: "camera.metering.none").fontSize(20).color(Color.gray.opacity(0.2))
            Text(content).multilineTextAlignment(.center).lineSpacing(5).font(.system(size: 14)).foregroundColor(Color.gray).padding().maxWidth()
            Spacer()
        }.padding().emptyBg().tap0{
                    self.action?()
                }
    }
}

public struct EmptyLineView: View {

    var content: String
    var action: (() -> Void)? = nil

    public var body: some View {

        HStack {
            Spacer()
            Text(content).hint()
            Spacer()
        }.padding().mainBg().cornerRadius(6).tap0{
                    self.action?()
                }
    }
}


public struct EmptyLinkView<Destination: View>: View {

    var destination: Destination

    @Binding var isActive: Bool

    public init(destination: Destination, isActive: Binding<Bool>) {
        self.destination = destination
        self._isActive = isActive
    }

    public var body: some View {

        NavigationLink(destination: destination, isActive: $isActive){
            Text("")
        }.height(0).width(0)
    }
}



public struct BugFillLinkView: View {
    public init() {

    }

    public var body: some View {
        NavigationLink(destination: Text("")){
            Text("")
        }.height(0).width(0)
    }
}