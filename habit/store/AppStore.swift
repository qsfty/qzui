//
// Created by 李和 on 2021/8/2.
//

import SwiftUI

class AppStore: ObservableObject {

    @Published var theme: ThemeMode = .LIGHT

    func color(myColor: ColorMode) -> Color{
        colorMap[theme]![myColor]!
    }
}