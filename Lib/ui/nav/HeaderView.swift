//
// Created by 强子 on 2021/8/7.
//


import SwiftUI

/**
 * 大标题栏
 */
public struct BigHeaderView:View {

    var title: String
    var second: Bool
    var hideTitle: String

    init(_ title: String, second: Bool = false, hideTitle: String = "") {
        self.title = title
        self.second = second
        self.hideTitle = hideTitle
    }

     public var body: some View {
        VStack{
            Text(hideTitle).hint().height(50).offset(y: -20)
            HStack{
                Text(self.title).bold().fontSize(self.second ? 28 : 36).primary()
                Spacer()
            }.height(50)
        }.padding(.horizontal, 20)
                .padding(.top, MyUIUtil.getStatusBarHeight())
                .mainBg0()
    }

}

/**
 * 标题栏
 */
public struct HeaderView: View {

    var title: String
    var showTitle: Bool = true
    var backAction: (() -> Void)? = nil
    var isSheet: Bool = false

    public init(title: String, showTitle: Bool = true,isSheet: Bool = false, backAction: (() -> ())? = nil) {
        self.title = title
        self.showTitle = showTitle
        self.isSheet = isSheet
        self.backAction = backAction
    }

    public var body: some View {
        HStack{
            FixLeftLink(action: backAction)
            Spacer()
            Text(self.title).bold().opacity(self.showTitle ? 1: 0).animate().tap0{
                UIApplication.shared.endEditing()
            }
            Spacer()
            FixLeftLink(action: nil)
        }.height(50).padding(.top, self.isSheet ? 0 : MyUIUtil.getStatusBarHeight()).mainBg().zIndex(10)
    }
}


/**
 * 标题栏
 */
public struct HeaderCloseView: View {

    var title: String
    var showTitle: Bool = true
    var backAction: (() -> Void)? = nil
    var isSheet: Bool = false

    public init(title: String, showTitle: Bool = true,isSheet: Bool = false, backAction: (() -> ())? = nil) {
        self.title = title
        self.showTitle = showTitle
        self.isSheet = isSheet
        self.backAction = backAction
    }

    public var body: some View {
        HStack{
            FixLeftCloseLink(action: backAction)
            Spacer()
            Text(self.title).bold().opacity(self.showTitle ? 1: 0).animate()
            Spacer()
            FixLeftLink(action: nil)
        }.height(50).padding(.top, self.isSheet ? 0 : MyUIUtil.getStatusBarHeight()).mainBg().zIndex(10)
    }
}


public struct FullHeaderView: View {

    var title: String
    var showTitle: Bool = false
    var leftText: String = ""
    var leftAction: (() -> Void)? = nil
    var rightText: String = ""
    var rightAction: (() -> Void)? = nil

     public var body: some View {
        HStack{
            FixLeftTextLink(label: leftText, action: leftAction)
            Spacer()
            Text(self.title).bold().opacity(self.showTitle ? 1: 0)
            Spacer()
            FixRightLink(label: rightText, action: rightAction)
        }.height(50).padding(.top, MyUIUtil.getStatusBarHeight()).mainBg().zIndex(10)
    }
}


public struct HeaderWithRightView: View {

    var title: String
    var color: Color
    var backAction: (() -> Void)? = nil

    var rightText: String
    var rightAction: () -> Void

    public init(title: String,color: Color = Color.primary,  backAction: (() -> ())?, rightText: String, rightAction: @escaping () -> ()) {
        self.title = title
        self.color = color
        self.backAction = backAction
        self.rightText = rightText
        self.rightAction = rightAction
    }

    public var body: some View {
        HStack{
            FixLeftLink(action: backAction)
            Spacer()
            Text(self.title).bold().color(color)
            Spacer()
            FixRightLink(label: rightText, action: rightAction)
        }.height(50).padding(.top, MyUIUtil.getStatusBarHeight()).mainBg().zIndex(10)
    }
}


public struct FixLeftLink: View {

    public var action: (() -> Void)? = nil

    public init(action: (() -> ())? = nil) {
        self.action = action
    }

    public var body: some View {
        HStack{
            if(action != nil){
                Image(systemName: "chevron.backward")
            }
            Spacer()
        }.width(50).padding(.leading).emptyBg().tap0 {
            self.action?()
        }
    }
}


public struct FixLeftCloseLink: View {

    var action: (() -> Void)? = nil
    public var body: some View {
        HStack{
            if(action != nil){
                Image(systemName: "xmark")
            }
            Spacer()
        }.width(50).padding(.leading).emptyBg().tap0 {
            self.action?()
        }
    }
}



public struct FixLeftTextLink: View {

    var label: String
    var action: (() -> Void)? = nil
     public var body: some View {
        HStack{
            Spacer(minLength: 0)
            Text(label).fontSize(16).themeColor().padding(.vertical).tap0{
                self.action?()
            }
        }.width(50).padding(.leading).emptyBg().tap0 {
            self.action?()
        }
    }
}

public struct FixLeftText: View {

    var label: String
    var action: (() -> Void)? = nil
     public var body: some View {
        HStack{
            Text(label).fontSize(18).bold().primary().padding(.vertical)
            Spacer(minLength: 0)
        }.padding(.leading).emptyBg().tap0 {
            self.action?()
        }
    }
}


public struct FixRightLink: View {

    public var label: String
    public var action: (() -> Void)?

    public init(label: String, action: (() -> ())? = nil) {
        self.label = label
        self.action = action
    }

    public var body: some View {
        HStack{
            Spacer(minLength: 0)
            Text(label).fontSize(16).themeColor().padding(.vertical).tap0{
                self.action?()
            }
        }.width(50).padding(.trailing)
    }
}


public struct FixRightIconLink: View {

    var icon: String
    var iconColor: Color
    var action: (() -> Void)?

    public init(icon: String, iconColor: Color, action: (() -> ())?) {
        self.icon = icon
        self.iconColor = iconColor
        self.action = action
    }

    public var body: some View {
        HStack{
            Spacer(minLength: 0)
            Image(systemName: icon).font(.system(size: 22)).color(iconColor).tap0{
                self.action?()
            }
        }.width(50).padding(.trailing)
    }
}

public struct HeaderWithEditView: View {

    var title: String
    var showTitle: Bool
    var backButton: Bool? = false
    var backAction: (() -> Void)? = nil
    @Binding var editing: Bool

     public var body: some View {
        HStack{
            FixLeftLink(action: self.backAction)
            Spacer()
            Text(self.title).bold().opacity(self.showTitle ? 1: 0).animate()
            Spacer()
            FixRightLink(label: editing ? "退出" : "编辑").tap{
                self.editing.toggle()
            }
        }.height(50).padding(.top, MyUIUtil.getStatusBarHeight()).mainBg0()
    }
}

public struct HeaderWithCompleteView: View {

    var title: String
    var showTitle: Bool = true
    var backAction: (() -> Void)? = nil
    var completeAction: () -> Void

    public init(title: String, showTitle: Bool = true, backAction: (() -> ())?, completeAction: @escaping () -> ()) {
        self.title = title
        self.showTitle = showTitle
        self.backAction = backAction
        self.completeAction = completeAction
    }

    public var body: some View {
        HStack{
            FixLeftLink(action: self.backAction)
            Spacer(minLength: 0)
            Text(self.title).bold().opacity(self.showTitle ? 1 : 0).primary().lineLimit(1).animate()
            Spacer(minLength: 0)
            FixRightLink(label: "完成"){
                completeAction()
            }
        }.height(50).padding(.top, MyUIUtil.getStatusBarHeight()).mainBg()
    }
}



public struct HeaderWithAddView: View {

    var title: String
    var showTitle: Bool = true
    var backAction: (() -> Void)? = nil
    var completeAction: () -> Void

    public init(title: String, showTitle: Bool = true, backAction: (() -> ())?, completeAction: @escaping () -> ()) {
        self.title = title
        self.showTitle = showTitle
        self.backAction = backAction
        self.completeAction = completeAction
    }

    public var body: some View {
        HStack{
            FixLeftLink(action: self.backAction)
            Spacer(minLength: 0)
            Text(self.title).bold().opacity(self.showTitle ? 1 : 0).primary().lineLimit(1).animate()
            Spacer(minLength: 0)
            FixRightLink(label: "添加"){
                completeAction()
            }
        }.height(50).padding(.top, MyUIUtil.getStatusBarHeight()).mainBg()
    }
}



public struct HeaderWithRightIconView: View {

    var title: String
    var backButton: Bool? = false
    var backAction: (() -> Void)? = nil

    var rightIcon: String
    var rightIconColor: Color
    var rightAction: (() -> Void)? = nil

     public var body: some View {
        HStack{
            if(self.backButton ?? false){
                FixLeftLink(action: backAction)
            }
            Spacer()
            Text(self.title).bold().primary().lineLimit(1)
            Spacer()

            FixRightIconLink(icon: rightIcon, iconColor: rightIconColor, action: rightAction)

        }.height(50).padding(.top, MyUIUtil.getStatusBarHeight()).mainBg()
    }
}


public struct HeaderLeadingTitleWithRightIconView: View {

    var title: String

    var rightIcon: String
    var rightIconColor: Color
    var rightAction: (() -> Void)? = nil

     public var body: some View {
        HStack{
            FixLeftText(label: self.title)
            Spacer()
            FixRightIconLink(icon: rightIcon, iconColor: rightIconColor, action: rightAction)
        }.height(50).padding(.top, MyUIUtil.getStatusBarHeight()).mainBg()
    }
}


public struct HeaderImageNavView: View {

    var systemName: String

    var height: CGFloat = 50
    var imageHeight: CGFloat = 28

     public var body: some View {

        Image(systemName: systemName).font(.system(size: 20)).primary()

    }
}


