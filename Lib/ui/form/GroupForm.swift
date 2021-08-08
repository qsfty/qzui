//
// Created by 强子 on 2021/5/2.
//

import SwiftUI

public struct GroupView<Content: View>: View {

    public var content: Content

    public init(@ViewBuilder content:@escaping () -> Content) {
        self.content = content()
    }

    public var body: some View {
        VStack(spacing:0){
            content
        }.mainBg().cornerRadius(8).padding(.horizontal)
    }
}

public struct CornerGroup<Content: View>: View {

    public var content: Content

    public init(@ViewBuilder content:@escaping () -> Content) {
        self.content = content()
    }

    public var body: some View {
        VStack(spacing:0){
            content
        }.cornerRadius(8)
    }
}

public struct GroupFormView<Content: View>: View {

    public var cancel: () -> Void
    public var ok: () -> Void
    public var content: Content

    public init(cancel: @escaping () -> (), ok: @escaping () -> (), @ViewBuilder content:@escaping () -> Content) {
        self.cancel = cancel
        self.ok = ok
        self.content = content()
    }

    public var body: some View {
        VStack{
            content

            HStack{
                CancelButton{
                    cancel()
                }
                OkButton{
                    ok()
                }
            }.padding()
        }.mainBg().cornerRadius(8).padding(.horizontal)
    }

}
