//
// Created by 强子 on 2021/8/7.
//


import SwiftUI
import QzLib


let PADDING:CGFloat = 15

extension Text{

    public func hint() -> some View{
        self.font(.system(size: 12)).third()
    }

    public func smallHint() -> some View{
        self.font(.system(size: 10)).third()
    }

    public func link() -> some View {
        self.fontSize(14).color(Color.theme)
    }

    public func fontSize(_ fontSize: CGFloat) -> Text{
        self.font(.system(size: fontSize))
    }
}

extension View {

    public func fontSize(_ fontSize: CGFloat) -> some View{
        self.font(.system(size: fontSize))
    }

    public func white(_ bg: Color = Color.clear) -> some View {
        self.color(Color.white).bg(bg)
    }

    public func color(_ color: String) -> some View {
        self.modifier(ColorModifier(color))
    }

    public func color(_ color: Color) -> some View {
        self.foregroundColor(color)
    }

    public func bg(_ color: String) -> some View {
        self.modifier(BackgroundColorModifier(color))
    }

    public func bg(_ color: Color) -> some View {
        self.background(color)
    }

    public func bgRed() -> some View {
        self.overlay(Color.red).opacity(0.2)
    }

    public func bgBlue() -> some View {
        self.overlay(Color.blue)
    }

    public func bgYellow() -> some View {
        self.overlay(Color.yellow)
    }


    public func primary() -> some View{
        self.color("primary")
    }

    public func gray(_ opacity: Double = 1) -> some View {
        self.foregroundColor(Color.gray.opacity(opacity))
    }

    public func third() -> some View {
        self.color(Color.third)
    }

    public func placeholder() -> some View {
        self.color(Color.placeholder)
    }

    public func secondary() -> some View{
        self.color("second")
    }

    public func second() -> some View{
        self.color("second")
    }

    public func emptyMainBg() -> some View {
        self.color("mainBg")
    }

    public func emptyMainBg0() -> some View {
        self.color("mainBg0")
    }

    public func mainBg() -> some View {
        self.bg("mainBg")
    }

    public func dialogBg() -> some View {
        self.bg("dialogBg")
    }

    public func mainBg1() -> some View {
        self.bg("mainBg1")
    }

    public func emptyBg() -> some View {
        self.background(Color.gray.opacity(0.001))
    }

    public func circleMainBg(radius: Int) -> some View {
        self.frame(width: radius.toFloat() * 2, height: radius.toFloat() * 2).mainBg().cornerRadius(radius.toFloat())
    }

    public func mainBg0() -> some View {
        self.bg("mainBg0")
    }

    public func mainBg00() -> some View {
        self.mainBg0()
    }

//    public func deleteFg() -> some View {
//        self.color(Color.deleteFg)
//    }
//
//    public func deleteFgTheme() -> some View {
//        self.color(Color.deleteTheme)
//    }
//
//    public func deleteBgTheme() -> some View {
//        self.bg(Color.deleteTheme)
//    }

    public func inputBg() -> some View {
        self.bg("inputBg")
    }

    public func divider() -> some View{
        self.color("mainBg0")
    }

    public func vipColor() -> some View {
        self.color("vipFg")
    }

    public func hoverBg() -> some View {
        self.bg("hoverBg")
    }

    public func primaryBg() -> some View {
        self.bg("background1")
    }

    public func secondaryBg() -> some View {
        self.bg("background2")
    }

    public func themeColor() -> some View {
        self.foregroundColor(Color.theme)
    }

    public func themeFg() -> some View {
        self.foregroundColor(Color.white)
    }

    public func themeBg() -> some View {
        self.bg(Color.theme)
    }

    public func theme() -> some View {
        self.foregroundColor(Color.white).themeBg()
    }

    public func deleteTheme() -> some View {
        self.foregroundColor(Color.white).bg(.delete)
    }

    public func deleteColor() -> some View {
        self.foregroundColor(.delete)
    }

    public func warn() -> some View {
        self.foregroundColor(.delete)
    }

    public func test(flag : Bool = true) -> some View{
        self.overlay(flag ? makeRandomColor().opacity(0.2) : Color.clear)
    }

    public func border(color: Color, radius: CGFloat = 3,  lineWidth: CGFloat = 0.5) -> some View {
        self.overlay(RoundedRectangle(cornerRadius: radius, style: .continuous).stroke(color, lineWidth: lineWidth))
    }
}


extension View {

    public func width(_ width: CGFloat) -> some View {
        Group{
            if(width >= 0){
                self.frame(width: width)
            }
            else{
                self
            }
        }
    }

    public func height(_ height: CGFloat) -> some View {
        Group{
            if(height >= 0){
                self.frame(height: height)
            }
            else{
                self
            }
        }
    }

    public func maxHeight() -> some View {
        self.frame(maxHeight: .infinity)
    }

    public func maxWidth() -> some View {
        self.frame(maxWidth: .infinity)
    }

    public func box(size: CGFloat) -> some View {
        self.width(size).height(size)
    }

    public func roundedBox(size: CGFloat, radius: CGFloat) -> some View {
        self.box(size: size).cornerRadius(radius)
    }

    public func roundedBoxText(size: CGFloat,color: Color, radius: CGFloat) -> some View {
        self.primary().box(size: size).bg(color).cornerRadius(radius)
    }

    public func roundedBoxText(size: CGFloat,radius: CGFloat) -> some View {
        self.primary().box(size: size).mainBg().cornerRadius(radius)
    }

    public func circleBox(size: CGFloat) -> some View {
        self.roundedBox(size: size, radius: size / 2.toFloat())
    }

    public func circleBoxText(size: CGFloat) -> some View {
        self.roundedBoxText(size: size, radius: size / 2.toFloat())
    }

    public func circleBoxText(size: CGFloat, color: Color) -> some View {
        self.roundedBoxText(size: size, color: color, radius: size / 2.toFloat())
    }

    public func fullScreen() -> some View {
        self.fullWidth()
                .height(UIScreen.main.bounds.height)
    }

    public func fullScreenWithStatusBar() -> some View {
        self.fullWidth().fullHeightWithStatusBar()
    }

    public func fullHeightWithStatusBar() -> some View {
        self.height(UIScreen.main.bounds.height)
    }

    public func fullHeightWithGap(x: CGFloat) -> some View {
        self.height(MyUIUtil.fullHeight() - x)
    }

    public func fullWidth() -> some View {
        self.width(MyUIUtil.fullWidth())
    }

    public func halfWidth() -> some View {
        self.width(MyUIUtil.fullWidth() / 2)
    }

    public func dialogWidth() -> some View {
        self.width(MyUIUtil.fullWidth() * 3 / 4)
    }

    public func halfHeight() -> some View {
        self.height(UIScreen.main.bounds.height / 2)
    }

    public func gapTopFourth() -> some View {
        self.offset(y: UIScreen.main.bounds.height / 4)
    }

    public func gapTopByHeight(height: CGFloat) -> some View {
        self.offset(y: (UIScreen.main.bounds.height - height) / 4)
    }

    public func gapTop(height: CGFloat) -> some View {
        self.offset(y: height)
    }

    public func fullWidthWithPadding() -> some View {
        self.fullWidthWithPadding(x: 40)
    }

    public func fullWidthWithPadding(x: Int) -> some View {
        self.width(MyUIUtil.fullWidth() - x.toFloat() * 2)
    }

    public func line() -> some View {
        self.fullWidth().height(1)
    }

    public func line2() -> some View {
        self.fullWidth().height(2)
    }

    public func line3() -> some View {
        self.fullWidth().height(3)
    }

    public func selfBar() -> some View {
        self.edgesIgnoringSafeArea(.all).navigationBarTitle("").navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
    }

    public func selfHeader() -> some View {
        self.padding(.top, MyUIUtil.getStatusBarHeight())
    }

    public func paddingBottomTabBar() -> some View {
        self.padding(.bottom, MyUIUtil.getTabbarHeight())
    }

    public func paddingBottomScreen() -> some View {
        self.padding(.bottom, MyUIUtil.getScreenBottomHeight())
    }

    public func pd(_ value: CGFloat = 15) -> some View {
        self.padding(value)
    }

    public func pda(_ v : CGFloat = 15, _ h: CGFloat = 15) -> some View {
        self.pdv(v).pdh(h)
    }

    public func pdt(_ value: CGFloat = 15) -> some View {
        self.padding(.top, value)
    }

    public func pdb(_ value: CGFloat = 15) -> some View {
        self.padding(.bottom, value)
    }

    public func pdv(_ value: CGFloat = 15) -> some View {
        self.padding(.vertical, value)
    }

    public func pdh(_ value: CGFloat = 15) -> some View {
        self.padding(.horizontal, value)
    }

    public func pdl(_ value: CGFloat = 15) -> some View {
        self.padding(.leading, value)
    }

    public func pdr(_ value: CGFloat = 15) -> some View {
        self.padding(.trailing, value)
    }

    public func listContentPadding() -> some View {
        self.padding(.horizontal).padding(.bottom, 10)
    }

    public func selfScreen() -> some View {
        self.mainBg0().edgesIgnoringSafeArea(.all).navigationBarTitle("").navigationBarTitleDisplayMode(.inline).navigationBarHidden(true).navigationBarBackButtonHidden(true)
    }

    public func selfNav() -> some View {
        self.navigationBarTitle("").navigationBarTitleDisplayMode(.inline).navigationBarHidden(true).navigationBarBackButtonHidden(true)
    }


    public func line1Dialog() -> some View{
        self.dialogWidth().padding(.vertical).dialogBg().cornerRadius(6).shadow(color: Color.gray.opacity(0.2), radius: 10).gapTop(height: 160).zIndex(10)
    }

}


public struct ColorModifier: ViewModifier {

    var color: String

    init(_ color: String) {
        self.color = color
    }

    public func body(content: Content) -> some View {
        content.foregroundColor(Color(color))
    }
}


public struct BackgroundColorModifier: ViewModifier {

    var color: String

    init(_ color: String) {
        self.color = color
    }

    public func body(content: Content) -> some View {
        content.background(Color(color))
    }
}



extension View {
    public func tapEffect() -> some View{
        self.modifier(TapModifier())
    }


    public func tap0(action:@escaping () -> Void) -> some View {
        self.modifier(Tap0Modifier(action: action))
    }

    public func tapCondition(active: Bool, action:(() -> Void)? = nil) -> some View {
        self.modifier(TapModifier(active: active, action: action))
    }

    public func tap(radius:CGFloat = 2, action:@escaping () -> Void) -> some View {
        self.emptyBg().modifier(TapModifier(radius: radius, action: action))
    }

    public func longTap(action: @escaping () -> Void) -> some View {
        self.onLongPressGesture(minimumDuration: 0.25, perform: action)
    }

    public func highTap(action: @escaping () -> Void) -> some View {
        self.modifier(HighTapModifier(action: action))
    }

    public func keyboardTapEffect() -> some View{
        self.modifier(TapModifier())
    }
}



public struct TapModifier: ViewModifier {

    var active: Bool = true
    var radius: CGFloat = 0
    var action: (() -> Void)? = nil

    @State var hover: Bool = false
    public func body(content: Content) -> some View {
        Group{
            if(active){
                content.onTapGesture {
                    self.hover = true
                    MyTimerUtil.after {
                        self.hover = false
                        self.action?()
                    }
                }.overlay(self.makeBg().cornerRadius(radius))
            }
            else{
                content
            }
        }
    }

    public func makeBg() -> some View {
        (self.hover ? Color("hoverBg").opacity(0.3) : Color.clear).cornerRadius(radius)
    }
}


public struct LongTapModifier: ViewModifier {

    var action: (() -> Void)? = nil

    @State var hover: Bool = false
    public func body(content: Content) -> some View {

        content.simultaneousGesture(LongPressGesture().onEnded{ k in
            self.hover = true
            MyTimerUtil.immediate {
                self.hover = false
                self.action?()
            }
        }, including: .none).overlay(self.makeBg())
    }

    public func makeBg() -> some View {
        (self.hover ? Color.gray.opacity(0.1) : Color.clear).cornerRadius(2)
    }
}


public struct Tap0Modifier: ViewModifier {

    var action: (() -> Void)? = nil

    @State var hover: Bool = false
    public func body(content: Content) -> some View {
        content.onTapGesture {
            self.action?()
        }
    }

}

public struct HighTapModifier: ViewModifier {

    var action: (() -> Void)? = nil

    @State var hover: Bool = false
    public func body(content: Content) -> some View {
        content.highPriorityGesture(TapGesture().onEnded {
            self.action?()
        })
    }

}


extension View {
    public func animate() -> some View {
        self.modifier(AnimationModifier())
    }
}

public struct AnimationModifier: ViewModifier {

    public func body(content: Content) -> some View {
        content.animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.2))
    }

}
