//
// Created by 强子 on 2022/1/28.
//

import SwiftUI

public struct Block: View {

    var width: CGFloat
    var height: CGFloat

    public init(){
        self.init(PADDING)
    }

    public init(_ size: CGFloat){
        self.init(size, size)
    }

    public init(_ width: CGFloat, _ height: CGFloat){
        self.width = width
        self.height = height
    }

    public var body: some View {
        Text("").width(width).height(height)
    }

}

public struct Splitter: View {
    public init() {

    }

    public var body: some View{
        Text("").height(0.6).maxWidth().background(Color("divider"))
        .padding(.leading, PADDING)
    }
}