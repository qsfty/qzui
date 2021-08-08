//
// Created by 强子 on 2021/8/7.
//

import SwiftUI

public struct BoxView<Content>: View where Content: View{
    public var content: Content
    public init(content: () -> Content){
        self.content = content()
    }

    public var body: some View {

        HStack{
            Spacer()
            content
            Spacer()
        }
    }
}