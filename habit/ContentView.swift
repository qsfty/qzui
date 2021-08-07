//
//  ContentView.swift
//  habit
//
//  Created by 李和 on 2021/8/2.
//

import SwiftUI
import WebKit
import Combine

struct ContentView: View {

    @EnvironmentObject var appStore: AppStore

    @State var showLeft = true
    @State var text = "<html><body><h1>Hello World</h1><p><strong>hell</strong> yeah!</p></body></html>"


    var body: some View {
        //定义枚举
        ScrollView(showsIndicators: false){

            TestDateUtilView().frame(maxWidth: .infinity)
        }.frame(minWidth: 200, idealWidth: 100, maxWidth: .infinity, minHeight: 200, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(appStore.color(myColor: .MAIN_BG0))

    }




}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
