//
// Created by 强子 on 2021/8/7.
//


import SwiftUI


extension Text{

    func hint() -> some View{
        self.font(.system(size: 12)).third()
    }

    func link() -> some View {
        self.fontSize(14).color(Color("button0"))
    }

    func fontSize(_ fontSize: CGFloat) -> Text{
        self.font(.system(size: fontSize))
    }
}

extension View {

    func color(_ color: String) -> some View {
        self.modifier(ColorModifier(color))
    }

    func color(_ color: Color) -> some View {
        self.foregroundColor(color)
    }

    func bg(_ color: String) -> some View {
        self.modifier(BackgroundColorModifier(color))
    }

    func bg(_ color: Color) -> some View {
        self.background(color)
    }

    func bgRed() -> some View {
        self.background(Color.red)
    }

    func bgBlue() -> some View {
        self.background(Color.blue)
    }

    func bgYellow() -> some View {
        self.background(Color.yellow)
    }


    func primary() -> some View{
        self.color("primary")
    }

    func gray(_ opacity: Double = 1) -> some View {
        self.foregroundColor(Color.gray.opacity(opacity))
    }

    func third() -> some View {
        self.color("third")
    }

    func secondary() -> some View{
        self.color("second")
    }

    func second() -> some View{
        self.color("second")
    }

    func emptyMainBg() -> some View {
        self.color("mainBg")
    }

    func emptyMainBg0() -> some View {
        self.color("mainBg0")
    }

    func mainBg() -> some View {
        self.bg("mainBg")
    }

    func dialogBg() -> some View {
        self.bg("dialogBg")
    }

    func mainBg1() -> some View {
        self.bg("mainBg1")
    }

    func emptyBg() -> some View {
        self.background(Color.gray.opacity(0.001))
    }

    func circleMainBg(radius: Int) -> some View {
        self.frame(width: radius.toFloat() * 2, height: radius.toFloat() * 2).mainBg().cornerRadius(radius.toFloat())
    }

    func mainBg0() -> some View {
        self.bg("mainBg0")
    }

    func mainBg00() -> some View {
        self.mainBg0()
    }

    func deleteFg() -> some View {
        self.color(Color.deleteFg)
    }

    func deleteFgTheme() -> some View {
        self.color(Color.deleteTheme)
    }

    func deleteBgTheme() -> some View {
        self.bg(Color.deleteTheme)
    }

    func inputBg() -> some View {
        self.bg("inputBg")
    }

    func divider() -> some View{
        self.color("mainBg0")
    }

    func vipColor() -> some View {
        self.color("vipFg")
    }

    func hoverBg() -> some View {
        self.bg("hoverBg")
    }

    func primaryBg() -> some View {
        self.bg("background1")
    }

    func secondaryBg() -> some View {
        self.bg("background2")
    }

    func themeColor() -> some View {
        self.foregroundColor(Color("button0"))
    }

    func themeBg() -> some View {
        self.bg("button0")
    }

    func theme() -> some View {
        self.foregroundColor(Color.white).themeBg()
    }

    func test() -> some View{
        self.background(ColorUtil.makeColor().opacity(0.2))
    }
    func test2() -> some View{
        self.overlay(ColorUtil.makeColor().opacity(0.2))
    }

    func border(color: Color, radius: CGFloat = 3,  lineWidth: CGFloat = 0.5) -> some View {
        self.overlay(RoundedRectangle(cornerRadius: radius, style: .continuous).stroke(color, lineWidth: lineWidth))
    }
}

struct ColorModifier: ViewModifier {

    var color: String

    init(_ color: String) {
        self.color = color
    }

    func body(content: Content) -> some View {
        content.foregroundColor(Color(color))
    }
}


struct BackgroundColorModifier: ViewModifier {

    var color: String

    init(_ color: String) {
        self.color = color
    }

    func body(content: Content) -> some View {
        content.background(Color(color))
    }
}

