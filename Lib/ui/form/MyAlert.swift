//
// Created by 强子 on 2021/10/4.
//

import SwiftUI


public class AlertManager: ObservableObject {

    @Published public var isAlert: Bool = false

    private var type: String = ""
    private var title: String = ""
    private var info: String = ""
    private var action: (() -> Void)? = nil

    public init(){}

    public var alert: Alert {
        if(type == "delete" || type == "back"){
            return Alert(title: Text(title),
                    primaryButton: .destructive(Text("是的")) {
                        self.action?()
                        self.isAlert = false
                    },
                    secondaryButton: .cancel(Text("再想想")) {
                        self.isAlert = false
                    })
        }
        else{
            return Alert(title: Text(title),
                    primaryButton: .default(Text(info)) {
                        self.action?()
                        self.isAlert = false
                    },
                    secondaryButton: .default(Text("再想想")) {
                        self.isAlert = false
                    })
        }
    }

    public func deleteConfirm(title: String = "确认删除？", action: @escaping () -> Void) {
        self.title = title
        self.type = "delete"
        self.action = action
        self.isAlert = true
    }

    public func cleanConfirm(title: String = "确认清空？", action: @escaping () -> Void) {
        deleteConfirm(title: title, action: action)
    }


    public func backConfirm(title: String = "确认放弃修改？", action: @escaping () -> Void) {
        deleteConfirm(title: title, action: action)
    }


    public func saveConfirm(title: String = "确认保存",info:String = "是的", action: @escaping () -> Void) {
        self.title = title
        self.type = "save"
        self.info = info
        self.action = action
        self.isAlert = true
    }

}