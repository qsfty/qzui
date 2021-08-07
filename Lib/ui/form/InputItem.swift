//
// Created by 强子 on 2020/12/26.
//

import SwiftUI



struct ItemImageView: View {
    var icon: String
    var iconColor: Color
    var label: String

    var body: some View {
        HStack{
            if(icon != "" && iconColor != Color.clear){
                Image(systemName: icon).font(.system(size: 16)).color(iconColor).width(30)
            }
            Text(self.label).fontSize(14).second()
        }
    }

}

struct InputItemView: View, Equatable {

    static func == (lhs: InputItemView, rhs: InputItemView) -> Bool {
        lhs.value == rhs.value
    }

    var icon: String = ""
    var iconColor: Color = Color.clear
    var label: String
    @Binding var value: String
    var keyboardType: UIKeyboardType = .default
    var focusAction: ((Bool) -> Void)? = nil

    var body: some View {
        VStack(spacing: 10){
            HStack{
                ItemImageView(icon: icon, iconColor: iconColor, label: self.label).tap0{
                    UIApplication.shared.endEditing()
                }
                TextField("请填写\(label)", text: $value,  onEditingChanged: { v in
                    self.focusAction?(v)
                }).accentColor(Color.blue).multilineTextAlignment(.trailing)
                        .keyboardType(keyboardType)
            }
        }.padding().mainBg()
    }
}




struct InputItem2View: View,Equatable {

    static func == (lhs: InputItem2View, rhs: InputItem2View) -> Bool {
        lhs.value == rhs.value
    }


    var icon: String = ""
    var iconColor: Color = Color.clear
    var label: String
    @Binding var value: String

    var focusAction: ((Bool) -> Void)? = nil

    var body: some View {
        VStack(spacing: 10){
            HStack{
                ItemImageView(icon: icon, iconColor: iconColor, label: self.label)
                TextField("请填写\(label)", text: $value).accentColor(Color.blue).multilineTextAlignment(.trailing)
            }
        }.padding().mainBg()
    }
}


struct SelectItemView: View, Equatable {
    static func ==(lhs: SelectItemView, rhs: SelectItemView) -> Bool {
        lhs._id == rhs._id && lhs.options == rhs.options
    }

    var icon: String = ""
    var iconColor: Color = Color.clear
    var label: String
    @Binding var value: String
    var valueColor: Color = Color.primary
    var options: [SelectDO]

    @State var showPicker: Bool = false
    @State var timer: Timer? = nil

    var _id: String {
        _value.wrappedValue
    }

    var body: some View {
        return VStack(spacing: 10){
            HStack{
                ItemImageView(icon: icon, iconColor: iconColor, label: self.label)
                Spacer()
                if(self.value == "" || self.value == "请选择"){
                    Text("请选择").color(Color.gray.opacity(0.5))
                }
                else{
                    Text(getLabel(value: value)).color(valueColor)
                }
            }.tap{
                MyTimerUtil.animation2 {
                    self.showPicker.toggle()
                }
            }
            if(showPicker){
                Picker("", selection: $value) {
                    ForEach(Array(options.enumerated()), id: \.offset) {(i, item: SelectDO) in
                        Text(item.label).tag(item.value)
                    }
                }.width(MyUIUtil.fullWidth() - 80)
            }
        }.padding().mainBg().onChange(of: value) { _ in
            if(showPicker){
                self.debounce()
            }
        }.onChange(of: showPicker) { v in
            if(v){
                self.debounce()
            }
        }
    }

    func debounce(){
        if(true){
            return
        }
        if(self.timer != nil){
            self.timer?.invalidate()
        }
        self.timer = MyTimerUtil.sleep1{
            self.showPicker = false
            self.timer = nil
        }
    }

    func getLabel(value: String) -> String {
        let k = options.filter{$0.value == value}
        if(!k.isEmpty){
            return k[0].label
        }
        return ""
    }
}


struct ColorSelectItemView: View, Equatable {

    static func == (lhs: ColorSelectItemView, rhs: ColorSelectItemView) -> Bool {
        lhs.value == rhs.value
    }

    var icon: String = ""
    var iconColor: Color = Color.clear
    var label: String
    @Binding var value: String
    var valueColor: Color = Color.primary

    @State var showPicker: Bool = false
    @State var timer: Timer? = nil

    @State var chooseColor: Color = Color.clear

    var body: some View {
        VStack(spacing: 0){
            HStack{
                ItemImageView(icon: icon, iconColor: iconColor, label: self.label)
                Spacer()
                Text(self.value).hint()
                ColorPicker(selection: $chooseColor){
                    Text("")
                }.width(30)
            }
        }.padding().mainBg().onChange(of: chooseColor) { v in
            self.value = v.stringify()
            UIApplication.shared.endEditing()
        }.onAppear{
            self.chooseColor = parseHexColor(self.value)
        }
    }
}


struct SelectTimeRangeItemView: View {

    var icon: String = ""
    var iconColor: Color = Color.clear
    var label: String
    var value: String
    var valueColor: Color = Color.primary



    @State var showPicker: Bool = false

    @State var gmtBegin: Date = Date.init()
    @State var gmtEnd: Date = Date.init()


    var body: some View {
        ZStack(alignment: .top){
            HStack{
                ItemImageView(icon: icon, iconColor: iconColor, label: self.label)
                Spacer()
                if(self.value == "" || self.value == "请选择"){
                    Text("请选择").color(Color.gray.opacity(0.5))
                }
                else{
//                    Text(getLabel(value: value)).color(valueColor)
                }
            }.padding(.vertical, 8).mainBg().tap{
                MyTimerUtil.animation2 {
                    self.showPicker.toggle()
                }
            }.zIndex(10)
            if(showPicker){
                HStack(alignment: .center){
                    Spacer(minLength: 0)

                    MyDatePicker(selection: $gmtEnd, minuteInterval: 5, displayedComponents: .hourAndMinute)
                            .frame(width: MyUIUtil.fullWidth() / 2 - 70, height: 160, alignment: .center).clipped()


                    Text("到").width(40)

                    MyDatePicker(selection: $gmtEnd, minuteInterval: 5, displayedComponents: .hourAndMinute)
                            .frame(width: MyUIUtil.fullWidth() / 2 - 70, height: 160, alignment: .center).clipped()




//                    DatePicker(selection: $gmtEnd, displayedComponents: [.hourAndMinute]){
//                        Text("")
//                    }        .labelsHidden()
//                            .datePickerStyle(WheelDatePickerStyle())
//                            .preferredColorScheme(store.getScheme())
//                            .environment(\.colorScheme, store.getScheme() ?? .light)
//                            .environment(\.locale, Locale.init(identifier: "en_GB"))
//                            .width(MyUIUtil.fullWidth() / 2 - 70).height(140).clipped()
                    Spacer(minLength: 0)
                }.zIndex(1).offset(y: 40)
            }
        }.padding().mainBg()
    }


}




struct DatePickerItemView: View {

    var icon: String
    var iconColor: Color
    var label: String
    @Binding var date: Date
    var action: () -> Void


    var body: some View {
        VStack(spacing: 10){
            DatePicker(selection: $date, displayedComponents: [.hourAndMinute, .date]){
                HStack{
                    Image(systemName: icon).font(.system(size: 16)).color(iconColor).width(30)
                    Text(self.label).fontSize(14)
                    Spacer()
                }
            }
                    .environment(\.locale, Locale.init(identifier: "zh_Hans_CN"))
        }.padding().mainBg().tap{
            self.action()
        }
    }
}






struct SetItemView: View {

    var icon: String = ""
    var iconColor: Color = Color.clear
    var label: String
    var action: () -> Void

    var body: some View {

        HStack{
            ItemImageView(icon: icon, iconColor: iconColor, label: self.label)
            Spacer()
            Image(systemName: "chevron.forward").font(.system(size: 12))
        }.padding().emptyBg().tap {
            self.action()
        }

    }
}

struct RateItemView: View {

    var appId = ""
    var effectDate = ""
    var showIcon: Bool = false
    @State var text = "评价APP"

    var body: some View {
        SetItemView(icon: "star.fill", iconColor: showIcon ? Color.red: Color.clear, label: self.text) {
            let urlString = "itms-apps://itunes.apple.com/cn/app/\(appId)?mt=8&action=write-review"
            UIApplication.shared.open(URL(string: urlString)!)
        }.onAppear{
            if(MyDateUtil.isAfterDateString(target: effectDate)){
                self.text = "五星好评"
            }
        }
    }
}

struct UpgradeItemView: View {

    var bundle = ""
    var appId = ""
    @State var latestVersion = AppVersion(version: "0.0.1")

    var body: some View {

        Group {
            if(latestVersion.largeThan(other: AppVersionApi.getCurrentVersion())){
                SetItemView(label: "有新版本了,推荐升级\(latestVersion.version())"){
                    let urlString = "https://apps.apple.com/cn/app/%E8%AF%AD%E9%98%85/id\(appId)"
                    UIApplication.shared.open(URL(string: urlString)!)
                }
            }
            else{
                SetItemView(label: "当前已经是最新版本: \(AppVersionApi.getCurrentVersion().version())"){

                }
            }
        }.onAppear{
            AppVersionApi.getLatestVersion(bundle: self.bundle) { version in
                self.latestVersion = version
            }
        }


    }
}





struct SwitchSetItemView : View, Equatable {

    static func == (lhs: SwitchSetItemView, rhs: SwitchSetItemView) -> Bool {
        lhs._value.wrappedValue == rhs._value.wrappedValue
    }

    var icon: String = ""
    var iconColor: Color = Color.clear
    var label: String
    @Binding var value: Bool

    var body: some View {
        return HStack{
            ItemImageView(icon: icon, iconColor: iconColor, label: label)
            Spacer()
            SwitchButton(value: $value)
        }.padding()

    }
}


struct SwitchActionSetItemView : View, Equatable {

    static func == (lhs: SwitchActionSetItemView, rhs: SwitchActionSetItemView) -> Bool {
        lhs.value == rhs.value
    }

    var icon: String = ""
    var iconColor: Color = Color.clear
    var label: String
    var value: Bool
    var action: () -> Void

    var body: some View {

        HStack{
            ItemImageView(icon: icon, iconColor: iconColor, label: label)
            Spacer()
            SwitchActionButton(value: value, action: action).padding(.trailing, 16)
        }.padding(.leading, 15).padding(.vertical, 15).mainBg()

    }
}





struct LinkSetItemView<Destination: View> : View {

    var icon: String = ""
    var iconColor: Color = Color.clear
    var label: String
    var destination: Destination
    var disable: Bool = false
    @State var isActive: Bool = false


    var body: some View {

        VStack{
            HStack{
                ItemImageView(icon: icon, iconColor: iconColor, label: label)
                EmptyLinkView(destination: destination, isActive: $isActive)
                BugFillLinkView()
                Spacer()
                Image(systemName: "chevron.forward").font(.system(size: 12))
            }.padding().emptyBg().tap {
                if(disable){
                    return
                }
                self.isActive = true
            }
        }

    }
}


