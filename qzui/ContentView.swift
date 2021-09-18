//
//  ContentView.swift
//  qzui
//
//  Created by 强子 on 2021/8/7.
//

import SwiftUI
import QzLib

struct ContentView: View {
    public var body: some View {
         HStack{
             Text("hello")
             Text("vvvv")
         }.onAppear{
             //埋点
             ps("v1")
         }.stat(self)
    }
}

extension View {
    public func stat(_ instance: Any) -> some View{
        self.onAppear{
            //统计开始
            ps("enter page", String(describing: type(of: instance)))
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
