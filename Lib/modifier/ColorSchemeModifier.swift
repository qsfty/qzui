//
// Created by 强子 on 2021/8/7.
//


import SwiftUI


struct ColorSchemeModifier: ViewModifier {

    var mode: String
    func body(content: Content) -> some View {
        Group {
            if(mode == "dark"){
                content.preferredColorScheme(ColorScheme.dark)
            }
            else if(mode == "light"){
                content.preferredColorScheme(ColorScheme.light)
            }
            else{
                content.preferredColorScheme(nil)
            }
        }
    }
}
