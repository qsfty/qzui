//
// Created by 强子 on 2021/5/2.
//

import SwiftUI

struct GroupView<Content: View>: View {

    var content: Content

    init(@ViewBuilder content:@escaping () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack(spacing:0){
            content
        }.mainBg().cornerRadius(8).padding(.horizontal)
    }
}

struct CornerGroup<Content: View>: View {

    var content: Content

    init(@ViewBuilder content:@escaping () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack(spacing:0){
            content
        }.cornerRadius(8)
    }
}

struct GroupFormView<Content: View>: View {

    var cancel: () -> Void
    var ok: () -> Void
    var content: Content

    init(cancel: @escaping () -> (), ok: @escaping () -> (), @ViewBuilder content:@escaping () -> Content) {
        self.cancel = cancel
        self.ok = ok
        self.content = content()
    }

    var body: some View {
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
