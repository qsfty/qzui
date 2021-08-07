//
// Created by 强子 on 2021/8/7.
//


import SwiftUI

/**
 * 大标题栏
 */
struct BigHeaderView:View {

    var title: String
    var second: Bool
    var hideTitle: String

    init(_ title: String, second: Bool = false, hideTitle: String = "") {
        self.title = title
        self.second = second
        self.hideTitle = hideTitle
    }

    var body: some View {
        VStack{
            Text(hideTitle).hint().height(50).offset(y: -20)
            HStack{
                Text(self.title).bold().fontSize(self.second ? 28 : 36).primary()
                Spacer()
            }.height(50)
        }.padding(.horizontal, 20)
                .padding(.top, UIUtils.getStatusBarHeight())
                .mainBg0()
    }

}

/**
 * 标题栏
 */
struct HeaderView: View {

    var title: String
    var showTitle: Bool = true
    var backAction: (() -> Void)? = nil
    var body: some View {
        HStack{
            FixLeftLink(action: backAction)
            Spacer()
            Text(self.title).bold().opacity(self.showTitle ? 1: 0).animate()
            Spacer()
            FixLeftLink(action: nil)
        }.height(50).padding(.top, UIUtils.getStatusBarHeight()).mainBg().zIndex(10)
    }
}


struct FullHeaderView: View {

    var title: String
    var showTitle: Bool = false
    var leftText: String = ""
    var leftAction: (() -> Void)? = nil
    var rightText: String = ""
    var rightAction: (() -> Void)? = nil

    var body: some View {
        HStack{
            FixLeftTextLink(label: leftText, action: leftAction)
            Spacer()
            Text(self.title).bold().opacity(self.showTitle ? 1: 0)
            Spacer()
            FixRightLink(label: rightText, action: rightAction)
        }.height(50).padding(.top, UIUtils.getStatusBarHeight()).mainBg().zIndex(10)
    }
}


struct HeaderWithRightView: View {

    var title: String
    var showTitle: Bool
    var backButton: Bool? = false
    var backAction: (() -> Void)? = nil

    var rightText: String
    var rightAction: () -> Void

    var body: some View {
        HStack{
            FixLeftLink(action: backAction)
            Spacer()
            Text(self.title).bold().opacity(self.showTitle ? 1: 0).animate()
            Spacer()
            FixRightLink(label: rightText, action: rightAction)
        }.height(50).padding(.top, UIUtils.getStatusBarHeight()).mainBg().zIndex(10)
    }
}


struct FixLeftLink: View {

    var action: (() -> Void)? = nil
    var body: some View {
        HStack{
            if(action != nil){
                Image(systemName: "chevron.backward")
            }
            Spacer()
        }.width(50).padding(.leading, 20).emptyBg().tap0 {
            self.action?()
        }
    }
}


struct FixLeftTextLink: View {

    var label: String
    var action: (() -> Void)? = nil
    var body: some View {
        HStack{
            Text(label).fontSize(16).color("button0").padding(.vertical).tap0{
                self.action?()
            }
            Spacer(minLength: 0)
        }.width(50).padding(.leading, 20).emptyBg().tap0 {
            self.action?()
        }
    }
}

struct FixLeftText: View {

    var label: String
    var action: (() -> Void)? = nil
    var body: some View {
        HStack{
            Text(label).fontSize(18).bold().primary().padding(.vertical)
            Spacer(minLength: 0)
        }.padding(.leading, 20).emptyBg().tap0 {
            self.action?()
        }
    }
}


struct FixRightLink: View {

    var label: String
    var action: (() -> Void)?
    var body: some View {
        HStack{
            Spacer(minLength: 0)
            if(label == "newTask"){
                Image(systemName: "note.text.badge.plus").font(.system(size: 22)).themeColor().tap0{
                    self.action?()
                }
            }
            else{
                Text(label).fontSize(16).color("button0").padding(.vertical).tap0{
                    self.action?()
                }
            }

        }.width(50).padding(.trailing, 20)
    }
}


struct FixRightIconLink: View {

    var icon: String
    var iconColor: Color = Color.themeFg
    var action: (() -> Void)?
    var body: some View {
        HStack{
            Spacer(minLength: 0)
            Image(systemName: icon).font(.system(size: 22)).color(iconColor).tap0{
                self.action?()
            }
        }.width(40).padding(.trailing, 20)
    }
}

struct HeaderWithEditView: View {

    var title: String
    var showTitle: Bool
    var backButton: Bool? = false
    var backAction: (() -> Void)? = nil
    @Binding var editing: Bool

    var body: some View {
        HStack{
            FixLeftLink(action: self.backAction)
            Spacer()
            Text(self.title).bold().opacity(self.showTitle ? 1: 0).animate()
            Spacer()
            Text(editing ? "退出" : "编辑").fontSize(16).bold().color(Color.themeBg).tap {
                self.editing.toggle()
            }.width(50).padding(.vertical).padding(.trailing, 8)
        }.height(50).padding(.top, UIUtils.getStatusBarHeight()).mainBg0()
    }
}

struct HeaderWithCompleteView: View {

    var title: String
    var showTitle: Bool = true
    var backAction: (() -> Void)? = nil
    var completeAction: () -> Void

    var body: some View {
        HStack{
            FixLeftLink(action: self.backAction)
            Spacer()
            Text(self.title).bold().opacity(self.showTitle ? 1 : 0).primary().lineLimit(1).animate()
            Spacer()
            Text("完成").fontSize(16).bold().color(Color.themeBg).tap {
                self.completeAction()
            }.width(50).padding(.vertical).padding(.trailing, 8)

        }.height(50).padding(.top, UIUtils.getStatusBarHeight()).mainBg()
    }
}



struct HeaderWithRightIconView: View {

    var title: String
    var backButton: Bool? = false
    var backAction: (() -> Void)? = nil

    var rightIcon: String
    var rightIconColor: Color = Color.themeFg
    var rightAction: (() -> Void)? = nil

    var body: some View {
        HStack{
            if(self.backButton ?? false){
                FixLeftLink(action: backAction)
            }
            Spacer()
            Text(self.title).bold().primary().lineLimit(1)
            Spacer()

            FixRightIconLink(icon: rightIcon, iconColor: rightIconColor, action: rightAction)

        }.height(50).padding(.top, UIUtils.getStatusBarHeight()).mainBg()
    }
}


struct HeaderLeadingTitleWithRightIconView: View {

    var title: String

    var rightIcon: String
    var rightIconColor: Color = Color.themeFg
    var rightAction: (() -> Void)? = nil

    var body: some View {
        HStack{
            FixLeftText(label: self.title)
            Spacer()
            FixRightIconLink(icon: rightIcon, iconColor: rightIconColor, action: rightAction)
        }.height(50).padding(.top, UIUtils.getStatusBarHeight()).mainBg()
    }
}


struct HeaderImageNavView: View {

    var systemName: String

    var height: CGFloat = 50
    var imageHeight: CGFloat = 28

    var body: some View {

        Image(systemName: systemName).font(.system(size: 20)).primary()

    }
}


