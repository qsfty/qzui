//
// Created by 强子 on 2022/1/31.
//

import SwiftUI


public struct AutoGridView<Content: View>: View {

    var columns: [GridItem] = []
    var spacing: CGFloat
    var content: Content
    public init(column: Int,spacing: CGFloat = 10, @ViewBuilder content:@escaping () -> Content) {
        for i in 0..<column {
            columns.append(GridItem(.flexible(), spacing: spacing))
        }
        self.spacing = spacing
        self.content = content()
    }

    public var body: some View {
        LazyVGrid(columns: columns, spacing: spacing) {
            content
        }
    }
}