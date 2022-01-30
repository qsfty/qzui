//
// Created by 强子 on 2021/8/7.
//

import SwiftUI

public struct HintView: View {

    var hint: String

    init(_ hint: String){
        self.hint = hint
    }

     public var body: some View {

        HStack {
            Spacer(minLength: 0)
            Text("").hint()
            Text(hint).hint().padding(.horizontal, 5)
            Text("").hint()
            Spacer(minLength: 0)
        }.padding(.vertical).mainBg0()

    }
}
