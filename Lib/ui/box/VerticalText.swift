//
// Created by 强子 on 2022/2/2.
//

import SwiftUI


public struct VerticalText: View {

    var texts: [String]
    var color: Color

    public init(text: String, color: Color = Color.third) {
        self.texts = Array(text).map{String($0)}
        self.color = color
    }

    public var body: some View {

        VStack{
            ForEach(texts, id: \.self) { element in
                Text(String(element)).fontSize(8).color(color)
            }
        }
    }
}