//
// Created by 强子 on 2021/8/7.
//

import SwiftUI
import UIKit

public struct MyDatePicker: UIViewRepresentable {

    @Binding var selection: Date
    let minuteInterval: Int
    let displayedComponents: DatePickerComponents

    public func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    public func makeUIView(context: UIViewRepresentableContext<MyDatePicker>) -> UIDatePicker {
        let picker = UIDatePicker()
        // listen to changes coming from the date picker, and use them to update the state variable
        picker.addTarget(context.coordinator, action: #selector(Coordinator.dateChanged), for: .valueChanged)
        picker.minuteInterval = minuteInterval
        picker.locale = Locale.init(identifier: "en_GB")
        picker.preferredDatePickerStyle = .wheels
        return picker
    }

    public func updateUIView(_ picker: UIDatePicker, context: UIViewRepresentableContext<MyDatePicker>) {
        picker.date = selection

        switch displayedComponents {
        case .hourAndMinute:
            picker.datePickerMode = .time
        case [.hourAndMinute, .date]:
            picker.datePickerMode = .dateAndTime
        default:
            break
        }
    }

    public class Coordinator {
        let datePicker: MyDatePicker

        init(_ datePicker: MyDatePicker) {
            self.datePicker = datePicker
        }

        @objc func dateChanged(_ sender: UIDatePicker) {
            datePicker.selection = sender.date
        }
    }
}