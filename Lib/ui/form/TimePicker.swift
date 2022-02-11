//
// Created by 强子 on 2021/10/3.
//

import QzLib
import SwiftUI

public var allIntervalTimes: [SelectDO] {
    var result: [SelectDO] = []
    for i in 0..<24 {
        for j in 0..<60 {
            if(j % 5 == 0){
                result.append(SelectDO(label: "\(getTwo(x: i)):\(getTwo(x: j))", value: "\(getTwo(x: i)):\(getTwo(x: j))"))
            }
        }
    }
    return result
}


public func getTwo(x: Int) -> String {
    x < 10 ? "0\(x)" : "\(x)"
}

public func gapTime(time: String, gap: Int) -> String {
    if(time.count == 5){
        var hour = String(time.split(separator: ":")[0]).toInt()
        var minute = String(time.split(separator: ":")[1]).toInt()
        minute += gap
        if(minute < 0){
            hour -= 1
            minute += 60
            if(hour < 0){
                hour = 23
            }
        }
        else if(minute >= 60){
            hour += 1
            minute -= 60
            if(hour > 23){
                hour = 0
            }
        }
        return "\(getTwo(x: hour)):\(getTwo(x: minute))"
    }
    return ""
}


public struct PickTimeView : View{

    @Binding var time: String
    var group: String

    @State var options: [SelectDO] = []

    public init(time: Binding<String>, group: String) {
        self._time = time
        self.group = group
    }

    public var body: some View {

        Picker(selection: $time, label: Text("")){
            ForEach(Array(options.enumerated()), id: \.offset) {(_, item: SelectDO) in
                Text(item.label).tag(item.value)
            }
        }.pickerStyle(WheelPickerStyle()).onAppear{
            self.options = allIntervalTimes
        }
    }
}
