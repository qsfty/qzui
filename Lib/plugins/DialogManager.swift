//
// Created by 强子 on 2022/2/3.
//


import SwiftUI
import QzLib
public class DialogManager: ObservableObject {

    @Published public var showTimeChooseDialog: Bool = false
    @Published public var showNumberChooseDialog: Bool = false
    @Published public var showPreDefineChooseDialog: Bool = false
    @Published public var showYearMonthDialog: Bool = false
    @Published public var defaultTime: String = ""
    @Published public var defaultValue: String = ""
    @Published public var defineData: [String] = []

    public var title: String = ""
    public var action: ((String) -> Void)? = nil
    public var cancel: (() -> Void)? = nil

    public init() {

    }

    public func showTimeChoose(title: String, time: String, cb:@escaping (String) -> Void){
        self.title = title
        self.showTimeChooseDialog = true
        self.defaultTime = time
        self.action = cb
    }

    public func showNumberChoose(title: String, value: String, cb:@escaping (String) -> Void){
        self.title = title
        self.showNumberChooseDialog = true
        self.defaultValue = value
        self.action = cb
    }

    public func showPreDefineChoose(title: String, value: String,defineData: [String], cb:@escaping (String) -> Void){
        self.title = title
        self.defineData = defineData
        self.showPreDefineChooseDialog = true
        self.defaultValue = value
        self.action = cb
    }

    public func showYearMonthChoose(title: String, value: String, cb:@escaping (String) -> Void){
        self.title = title
        self.showYearMonthDialog = true
        self.defaultValue = value
        self.action = cb
    }
}
