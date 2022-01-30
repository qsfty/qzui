//
// Created by 强子 on 2020/12/26.
//

import SwiftUI
import QzLib

public var verticalGap:CGFloat = 15

public struct ItemImageView: View {
    public var label: String
    public var color: Color = Color.second

    public init(label: String, color: Color = Color.second) {
        self.label = label
        self.color = color
    }

    public var body: some View {
        HStack{
            Text(self.label).fontSize(14).color(color)
        }
    }

}

public struct InputItemView: View, Equatable {

    public static func  == (lhs: InputItemView, rhs: InputItemView) -> Bool {
        lhs.value == rhs.value
    }

    var label: String
    var placeholder: String = ""
    @Binding var value: String
    var keyboardType: UIKeyboardType = .default
    var focusAction: ((Bool) -> Void)? = nil

    public init(label: String, placeholder: String = "", value: Binding<String>, keyboardType: UIKeyboardType = .default, focusAction: ((Bool) -> ())? = nil) {
        self.label = label
        self.placeholder = placeholder == "" ? "请填写\(label)" : placeholder
        self._value = value
        self.keyboardType = keyboardType
        self.focusAction = focusAction
    }

    public var body: some View {
        return HStack{
            ItemImageView(label: self.label).tap0{
                UIApplication.shared.endEditing()
            }
            TextField(placeholder, text: $value,  onEditingChanged: { v in
                self.focusAction?(v)
            }).accentColor(Color.blue).multilineTextAlignment(.trailing)
                    .keyboardType(keyboardType)
                    .font(.system(size: 14))
        }.cellStyle()
    }
}




public struct PasswordView: View, Equatable {

    public static func == (lhs: PasswordView, rhs: PasswordView) -> Bool {
        lhs.value == rhs.value
    }

    var label: String
    var placeholder: String = ""
    @Binding var value: String
    var keyboardType: UIKeyboardType = .default
    var focusAction: ((Bool) -> Void)? = nil

    public init(label: String, placeholder: String = "", value: Binding<String>, keyboardType: UIKeyboardType = .default, focusAction: ((Bool) -> ())? = nil) {
        self.label = label
        self.placeholder = placeholder == "" ? "请填写\(label)" : placeholder
        self._value = value
        self.keyboardType = keyboardType
        self.focusAction = focusAction
    }

    public var body: some View {
        return HStack{
            ItemImageView(label: self.label).tap0{
                UIApplication.shared.endEditing()
            }
            SecureField(placeholder, text: $value).accentColor(Color.blue).multilineTextAlignment(.trailing)
                    .keyboardType(keyboardType)
                    .font(.system(size: 14))
        }.cellStyle()
    }
}


public struct InlineTextAreaView: View, Equatable {

    public static func  == (lhs: InlineTextAreaView, rhs: InlineTextAreaView) -> Bool {
        lhs.value == rhs.value
    }

    var label: String
    var placeholder: String = ""
    @Binding var value: String
    var focusAction: ((Bool) -> Void)? = nil

    public init(label: String, placeholder: String = "", value: Binding<String>, keyboardType: UIKeyboardType = .default, focusAction: ((Bool) -> ())? = nil) {
        self.label = label
        self.placeholder = placeholder == "" ? "请填写\(label)" : placeholder
        self._value = value
        self.focusAction = focusAction
    }

    public var body: some View {
        return HStack(alignment: .top){
            ItemImageView(label: self.label).tap0{
                UIApplication.shared.endEditing()
            }

            TextEditor(text: $value).accentColor(Color.blue).multilineTextAlignment(.trailing)
                    .font(.system(size: 14))
                    .height(100)
        }.cellStyle()
    }
}


public struct TextAreaView: View, Equatable {

    public static func  == (lhs: TextAreaView, rhs: TextAreaView) -> Bool {
        lhs.value == rhs.value
    }

    @Binding var value: String
    var height: CGFloat = 60
    var focusAction: ((Bool) -> Void)? = nil

    public init(height: CGFloat = 60, value: Binding<String>, focusAction: ((Bool) -> ())? = nil) {
        self.height = height
        self._value = value
        self.focusAction = focusAction
    }

    public var body: some View {
        TextEditor(text: $value).accentColor(Color.blue).multilineTextAlignment(.leading)
                .font(.system(size: 14))
                .height(height).cellStyle()
    }
}



public struct SelectItemView: View, Equatable {
    public static func  ==(lhs: SelectItemView, rhs: SelectItemView) -> Bool {
        lhs._id == rhs._id && lhs.options == rhs.options
    }

    var label: String
    @Binding var value: String
    var valueColor: Color = Color.primary
    var options: [SelectDO]

    @State var showPicker: Bool = false

    var _id: String {
        _value.wrappedValue
    }

    public init(label: String, value: Binding<String>, valueColor: Color = Color.primary, options: [SelectDO], showPicker: Bool = false) {
        self.label = label
        self._value = value
        self.valueColor = valueColor
        self.options = options
        self.showPicker = showPicker
    }

    public var body: some View {
        return VStack(spacing: 0){
            HStack{
                ItemImageView(label: self.label)
                Spacer()
                if(self.value == "" || self.value == "请选择"){
                    Text("请选择").fontSize(14).color(Color.gray.opacity(0.5))
                }
                else{
                    Text(getLabel(value: value)).fontSize(14).color(valueColor)
                }
            }.padding(.vertical, verticalGap).emptyBg().tap{
                UIApplication.shared.endEditing()
                self.showPicker.toggle()
            }
            if(showPicker){
                Picker("", selection: $value) {
                    ForEach(Array(options.enumerated()), id: \.offset) {(i, item: SelectDO) in
                        Text(item.label).tag(item.value)
                    }
                }.pickerStyle(WheelPickerStyle()).width(MyUIUtil.fullWidth() - 80)
            }
        }.padding(.horizontal).mainBg()
    }

    func getLabel(value: String) -> String {
        let k = options.filter{$0.value == value}
        if(!k.isEmpty){
            return k[0].label
        }
        return ""
    }
}

public struct DatePickItemView: View {

    var label: String
    @Binding var value: String
    @State var showPicker: Bool = false

    @State var mydate : Date = Date.init()

    public init(label: String, value: Binding<String>,  showPicker: Bool = false) {
        self.label = label
        self._value = value
        self.showPicker = showPicker

        if(value.wrappedValue != ""){
            self.mydate = MyDateUtil.parseDate(value.wrappedValue)!
        }
    }

    public var body: some View {
         VStack(spacing: 0){
            HStack{
                ItemImageView(label: self.label)
                Spacer()
                ItemValueView(value: $value)
            }.padding(.vertical, verticalGap).emptyBg().tap{
                UIApplication.shared.endEditing()
                self.showPicker.toggle()
                if(showPicker){
                    if(self.value == ""){
                        self.value = MyDateUtil.formatDate(Date.init())
                    }
                }
            }
            if(showPicker){
                DatePicker(selection: $mydate,
                        displayedComponents: .date,
                        label: {Text("")})
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                        .environment(\.locale,  Locale.init(identifier: "zh-CN"))
                .width(MyUIUtil.fullWidth() - 80)
            }
        }.padding(.horizontal).mainBg().onChange(of: mydate) {v in
            self.value = MyDateUtil.formatDate(v)
        }
    }


}



public struct ItemValueView: View {

    @Binding var value: String
    var placeholder = "请选择"

    public var body: some View {
        if(self.value == "" || self.value == "请选择"){
            Text(placeholder).fontSize(14).color(Color.gray.opacity(0.5))
        }
        else{
            Text(value).fontSize(14)
        }
    }
}


public struct DatePick2ItemView: View {

    var label: String
    var gapLabel: String
    @Binding var value1: String
    @Binding var value2: String
    @State var showPicker: Bool = false

    @State var mydate1 : Date = Date.init()
    @State var mydate2 : Date = Date.init()

    public init(label: String, gapLabel: String, value1: Binding<String>,value2: Binding<String>) {
        self.label = label
        self.gapLabel = gapLabel
        self._value1 = value1
        self._value2 = value2

        if(_value1.wrappedValue != ""){
            self.mydate1 = MyDateUtil.parseDate(value1.wrappedValue)!
        }

        if(_value2.wrappedValue != ""){
            self.mydate2 = MyDateUtil.parseDate(value2.wrappedValue)!
        }

    }

    public var body: some View {
        VStack(spacing: 0){
            HStack{
                ItemImageView(label: self.label)
                Spacer()
                ItemValueView(value: $value1)
                Text(self.gapLabel).hint()
                ItemValueView(value: $value2)
            }.padding(.vertical, verticalGap).emptyBg().tap{
                self.showPicker.toggle()
                if(showPicker){
                    if(self.value1 == ""){
                        self.value1 = MyDateUtil.formatDate(Date.init())
                    }
                    if(self.value2 == ""){
                        self.value2 = MyDateUtil.formatDate(Date.init())
                    }
                }
            }
            if(showPicker){
                HStack{
                    DatePicker(selection: $mydate1,
                            displayedComponents: .date,
                            label: {Text("")})
                            .datePickerStyle(WheelDatePickerStyle())
                            .labelsHidden()
                            .environment(\.locale,  Locale.init(identifier: "zh-CN"))
                            .width((MyUIUtil.fullWidth() - 80)/2)
                            .height(130)
                            .scaleEffect(0.6, anchor: .center)
                    DatePicker(selection: $mydate2,
                            displayedComponents: .date,
                            label: {Text("")})
                            .datePickerStyle(WheelDatePickerStyle())
                            .labelsHidden()
                            .environment(\.locale,  Locale.init(identifier: "zh-CN"))
                            .width((MyUIUtil.fullWidth() - 80)/2)
                            .height(130)
                            .scaleEffect(0.6, anchor: .center)
                }.height(130)
            }
        }.padding(.horizontal).mainBg().onChange(of: mydate1) {v in
            self.value1 = MyDateUtil.formatDate(v)
        }.onChange(of: mydate2) {v in
            self.value2 = MyDateUtil.formatDate(v)
        }
    }


}


public struct TimePick2ItemView: View {

    var label: String
    var gapLabel: String
    var group: String = "all"

    @Binding var value1: String
    @Binding var value2: String
    @State var showPicker: Bool = false

    public init(label: String, gapLabel: String, group:String = "all", value1: Binding<String>,value2: Binding<String>) {
        self.label = label
        self.gapLabel = gapLabel
        self.group = group
        self._value1 = value1
        self._value2 = value2
    }

    public var body: some View {
        ZStack(alignment: .top){
            HStack{
                ItemImageView(label: self.label)
                Spacer()
                ItemValueView(value: $value1)
                Text(self.gapLabel).hint()
                ItemValueView(value: $value2)
            }.padding(.vertical, verticalGap).emptyBg().tap{
                self.showPicker.toggle()
            }.zIndex(10)
            if(showPicker){
                HStack(alignment: .center){
                    Spacer(minLength: 0)

                    PickTimeView(time: $value1, group: group)
                            .frame(width: MyUIUtil.fullWidth() / 2 - 70, height: 160, alignment: .center).clipped()

                    Text("到").width(40)

                    PickTimeView(time: $value2, group: group)
                            .frame(width: MyUIUtil.fullWidth() / 2 - 70, height: 160, alignment: .center).clipped()

                    Spacer(minLength: 0)
                }.zIndex(1).offset(y: 40)
            }
        }.padding(.horizontal).mainBg()
    }


}


public struct SliderItemView: View, Equatable {

    public static func == (lhs: SliderItemView, rhs: SliderItemView) -> Bool {
        lhs.value == rhs.value
    }

    var label: String
    @Binding var value: CGFloat

    var minValue: CGFloat
    var maxValue: CGFloat

    @State var showSlider: Bool = false

    public init(label: String, value: Binding<CGFloat>, minValue: CGFloat = 0, maxValue: CGFloat = 100) {
        self.label = label
        self._value = value
        self.minValue = minValue
        self.maxValue = maxValue
    }

    public var body: some View {
        return VStack{

            HStack{
                ItemImageView(label: self.label)
                Spacer()
                if(self.maxValue == 1){
                    Text("\(String(format: "%.2f", self.value))").fontSize(14).hint()
                }
                else{
                    Text("\(self.value.toInt())").fontSize(14).hint()
                }
            }.cellStyle().tap{
                UIApplication.shared.endEditing()
                self.showSlider.toggle()
            }
            if(showSlider){
                Slider(value: $value,
                        in: minValue...maxValue,
                        minimumValueLabel: Text(""),
                        maximumValueLabel: Text("")) {
                    Text("")
                        }
            }
        }.mainBg().onAppear{

        }
    }
}




public struct ColorSelectItemView: View, Equatable {

    public static func  == (lhs: ColorSelectItemView, rhs: ColorSelectItemView) -> Bool {
        lhs.value == rhs.value
    }

    var label: String
    var hint: String = ""
    @Binding var value: String
    var valueColor: Color = Color.primary

    @State var showPicker: Bool = false
    @State var timer: Timer? = nil

    @State var chooseColor: Color = Color.clear

    public init(label: String,hint: String = "", value: Binding<String>, valueColor: Color = Color.primary, showPicker: Bool = false, timer: Timer? = nil, chooseColor: Color = .clear) {
        self.label = label
        if(hint != ""){
            self.hint = "(" +  hint + ")"
        }
        self._value = value
        self.valueColor = valueColor
        self.showPicker = showPicker
        self.timer = timer
    }

    public var body: some View {
        return HStack{
            ItemImageView(label: self.label)
            Text(hint).smallHint()
            Spacer()
            Text(self.value).fontSize(14).hint()
            ColorPicker(selection: $chooseColor){
                Text("")
            }.height(20).width(20)
        }.cellStyle().mainBg().onChange(of: chooseColor) { v in
            self.value = v.stringify()
            UIApplication.shared.endEditing()
        }.onAppear{
            self.chooseColor = parseHexColor(self.value)
        }.onChange(of: value){v in
            self.chooseColor = parseHexColor(v)
        }
    }
}

extension View {

    public func cellStyle() -> some View {
        self.padding(.horizontal).padding(.vertical, verticalGap)
    }
}

public struct SetItemView: View {

    public var label: String
    public var color: Color = Color.primary
    public var action: () -> Void

    public var body: some View {

        HStack{
            ItemImageView(label: self.label, color: color)
            Spacer()
            Image(systemName: "chevron.forward").font(.system(size: 12))
        }.cellStyle().emptyBg().tap {
            self.action()
        }

    }
}

public struct RateItemView: View {

    public var appId = ""
    public  var effectDate = ""
    public  var showIcon: Bool = false
    @State public var text = "评价APP"

    public init(appId: String, effectDate: String, showIcon: Bool = false) {
        self.appId = appId
        self.effectDate = effectDate
        self.showIcon = showIcon
    }

    public var body: some View {
        SetItemView(label: self.text) {
            let urlString = "itms-apps://itunes.apple.com/cn/app/\(appId)?mt=8&action=write-review"
            UIApplication.shared.open(URL(string: urlString)!)
        }.onAppear{
            if(MyDateUtil.isAfterDateString(target: effectDate)){
                self.text = "五星好评"
            }
        }
    }
}

public struct UpgradeItemView: View {

    var bundle = ""
    var appId = ""
    var latestVersion: AppVersion

    public init(bundle: String, appId: String, latestVersion: AppVersion) {
        self.bundle = bundle
        self.appId = appId
        self.latestVersion = latestVersion
    }

    public var body: some View {
        Group {
            if(latestVersion.largeThan(other: AppVersionApi.getCurrentVersion())){
                SetItemView(label: "有新版本了,推荐升级\(latestVersion.version())", color: Color.red){
                    let urlString = "https://apps.apple.com/cn/app/%E8%AF%AD%E9%98%85/id\(appId)"
                    UIApplication.shared.open(URL(string: urlString)!)
                }
            }
        }
    }
}





public struct SwitchSetItemView : View, Equatable {

    public static func  == (lhs: SwitchSetItemView, rhs: SwitchSetItemView) -> Bool {
        lhs._value.wrappedValue == rhs._value.wrappedValue
    }

    var label: String
    var hint: String = ""
    @Binding var value: Bool

    public init(label: String, hint: String = "", value: Binding<Bool>) {
        self.label = label
        if(hint != ""){
            self.hint = "(" + hint + ")"
        }
        self._value = value
    }

    public var body: some View {
        return HStack{
            ItemImageView(label: label)
            Text(hint).smallHint()
            Spacer()
            SwitchButton(value: $value)
        }.cellStyle()

    }
}



public struct SwitchChooseItemView : View, Equatable {

    public static func  == (lhs: SwitchChooseItemView, rhs: SwitchChooseItemView) -> Bool {
        lhs._value.wrappedValue == rhs._value.wrappedValue
    }

    var label: String
    var hint: String = ""
    @Binding var value: String
    var options: [SelectDO]

    public init(label: String, hint: String = "", value: Binding<String>, options: [SelectDO]) {
        self.label = label
        if(hint != ""){
            self.hint = "(" + hint + ")"
        }
        self._value = value
        self.options = options
    }

    public var body: some View {
        return HStack{
            ItemImageView(label: label)
            Text(hint).smallHint()
            Spacer()
            SwitchChooseButton(value: $value, options: options)
        }.padding(.horizontal).padding(.vertical, verticalGap - 2)

    }
}





public struct SwitchActionSetItemView : View, Equatable {

    public static func  == (lhs: SwitchActionSetItemView, rhs: SwitchActionSetItemView) -> Bool {
        lhs.value == rhs.value
    }

    var label: String
    var value: Bool
    var action: () -> Void
    var gap: CGFloat

    public init(label: String, value: Bool,gap: CGFloat = -1, action: @escaping () -> ()) {
        self.label = label
        self.value = value
        self.action = action
        self.gap = gap
    }

    public var body: some View {

        HStack{
            ItemImageView(label: label)
            Spacer()
            SwitchActionButton(value: value, action: action)
        }.padding(.horizontal)
                .padding(.vertical, gap < 0 ? verticalGap : gap).mainBg()

    }
}





public struct LinkSetItemView<Destination: View> : View {
    var label: String
    var destination: Destination
    var vip: Bool
    var disable: Bool = false
    @State var isActive: Bool = false
    var action: (() -> Void)? = nil

    public init(label: String,vip: Bool = false, destination: Destination, disable: Bool = false, action:  (() -> Void)? = nil) {
        self.label = label
        self.vip = vip
        self.destination = destination
        self.disable = disable
        self.action = action
    }

    public var body: some View {

        HStack{
            ItemImageView(label: label)
            if(vip){
                VipLogo()
            }
            EmptyLinkView(destination: destination, isActive: $isActive)
            BugFillLinkView()
            Spacer()
            Image(systemName: "chevron.forward").font(.system(size: 12))
        }.cellStyle().emptyBg().tap {
            if(disable){
                action?()
                return
            }
            self.isActive = true
        }

    }
}


public struct ChooseItemView: View {
    var label: String
    @Binding var isActive: Bool

    public init(label: String, isActive: Binding<Bool>) {
        self.label = label
        self._isActive = isActive
    }

    public var body: some View {

        HStack{
            ItemImageView(label: label)
            Spacer()
            Image(systemName: "chevron.forward").font(.system(size: 12))
        }.cellStyle().emptyBg().tap {
            self.isActive.toggle()
        }

    }
}


public struct SimpleItemView: View {
    var label: String
    var action: () -> Void

    public init(label: String, action: @escaping () -> ()) {
        self.label = label
        self.action = action
    }

    public var body: some View {
        HStack{
            ItemImageView(label: label)
            Spacer()
        }.cellStyle().emptyBg().tap {
            self.action()
        }
    }
}