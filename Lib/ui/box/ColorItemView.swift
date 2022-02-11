//
// Created by 强子 on 2022/1/28.
//

import SwiftUI
import QzLib

public struct ColorItemView: View {

    public var size: CGFloat
    public var color: String

    public init(size: CGFloat, color: String) {
        self.size = size
        self.color = color
    }

    public var body: some View {
        Circle().box(size: size).color(parseHexColor(color))
    }

}