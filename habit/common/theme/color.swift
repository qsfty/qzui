//
// Created by 李和 on 2021/8/2.
//

import SwiftUI


enum ThemeMode {
    case LIGHT;
    case DARK;
}

enum ColorMode {

    case MAIN_COLOR;
    case MAIN_BG;
    case MAIN_BG0;
    case HIGH_LIGHT_COLOR;

}


let colorMap: [ThemeMode:[ColorMode:Color]] = [
    .LIGHT: [
        .MAIN_COLOR: .black,
        .HIGH_LIGHT_COLOR: .blue,
        .MAIN_BG: .white,
        .MAIN_BG0: .white
    ],
    .DARK: [
        .MAIN_COLOR: .white,
        .HIGH_LIGHT_COLOR: trans(color: "#abe221"),
        .MAIN_BG: .black.opacity(0.7),
        .MAIN_BG0: .black.opacity(0.8)
    ]
]

func trans(color: String) -> Color {
    Color.blue
}