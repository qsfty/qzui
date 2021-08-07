//
//  ContentView.swift
//  habit
//
//  Created by 李和 on 2021/8/2.
//

import SwiftUI

struct Demo1: View {

    @EnvironmentObject var appStore: AppStore



    var body: some View {

        //定义枚举

        return VStack{

            Text("侥幸")
                .font(.system(size: 80))
                    .foregroundColor(appStore.color(myColor: .HIGH_LIGHT_COLOR))
                .padding()
        }.frame(minWidth: 200, idealWidth: 100, maxWidth: .infinity, minHeight: 200, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(appStore.color(myColor: .MAIN_BG0))
                .toolbar{
                    ToolbarItem(placement: ToolbarItemPlacement.destructiveAction) {
                        Button(action: {
                            appStore.theme = appStore.theme == .DARK ? .LIGHT : .DARK
                        }) {
                            Image(systemName: appStore.theme == .DARK ? "circle.lefthalf.fill" : "circle.righthalf.fill")
                        }
                    }
                }


    }
}