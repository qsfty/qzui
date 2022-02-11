//
// Created by 强子 on 2021/10/15.
//


import SwiftUI

public struct CircleLoadingView: View {

    public var color: Color

    public init(color: Color = .gray) {
        self.color = color
    }

    public var body: some View {
        ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: color))
    }
}
