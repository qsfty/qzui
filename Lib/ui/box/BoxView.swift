//
// Created by 强子 on 2021/8/7.
//

import SwiftUI

struct BoxView<Content>: View where Content: View{


    var content: Content


    init(content: () -> Content){
        self.content = content()
    }

    var body: some View {

        HStack{
            Spacer()
            content
            Spacer()
        }
    }
}