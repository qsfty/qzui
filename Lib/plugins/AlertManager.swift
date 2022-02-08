//
// Created by 强子 on 2022/2/2.
//

import SwiftUI

public class AlertManager: ObservableObject {

    @Published public var isAlert: Bool = false

    private var type: String = ""
    private var title: String = ""
    private var info: String = "是的"
    private var cancelText: String = "再想想"
    private var action: (() -> Void)? = nil
    private var cancel: (() -> Void)? = nil

    public init(){}

    public var alert: Alert {
        if(type == "delete" || type == "back" || type == "change"){
            return Alert(title: Text(title),
                    primaryButton: .destructive(Text(info)) {
                        self.action?()
                        self.isAlert = false
                    },
                    secondaryButton: .cancel(Text(cancelText)) {
                        self.isAlert = false
                        self.cancel?()
                    })
        }
        else if(type == "info"){
            return Alert.init(title: Text(title), message: Text(info),dismissButton: .default(Text(cancelText)) {
                self.cancel?()
            })
        }
        else{
            return Alert(title: Text(title),
                    primaryButton: .default(Text(cancelText)) {
                        self.isAlert = false
                        self.cancel?()
                    },
                    secondaryButton:.default(Text(info)) {
                        self.action?()
                        self.isAlert = false
                    })
        }
    }

    public func deleteConfirm(title: String = "确认删除？",info:String = "是的", cancelText:String = "再想想", cancel: (() -> Void)? = nil, action: @escaping () -> Void) {
        self.title = title
        self.type = "delete"
        self.info = info
        self.cancelText = cancelText
        self.cancel = cancel
        self.action = action
        self.isAlert = true
    }

    public func makeChangeConfirm(title: String = "确认执行此操作？", okText:String = "是的", cancelText:String = "放弃", cancel: (() -> Void)? = nil, action: @escaping () -> Void) {
        self.title = title
        self.type = "change"
        self.info = okText
        self.cancelText = cancelText
        self.cancel = cancel
        self.action = action
        self.isAlert = true
    }


    public func cleanConfirm(title: String = "确认清空？",info:String = "是的", cancelText:String = "再想想", action: @escaping () -> Void) {
        deleteConfirm(title: title,info:info, cancelText: cancelText,action: action)
    }


    public func backConfirm(title: String = "确认放弃修改？",info:String = "是的", cancelText:String = "再想想", action: @escaping () -> Void) {
        deleteConfirm(title: title,info:info, cancelText: cancelText, action: action)
    }


    public func saveConfirm(title: String = "确认保存", info:String = "是的", cancelText:String = "再想想", action: @escaping () -> Void) {
        self.title = title
        self.type = "save"
        self.info = info
        self.cancelText = cancelText
        self.action = action
        self.isAlert = true
    }



    public func info(title: String = "提示", info:String = "", cancelText:String = "好的", cancel: @escaping () -> Void) {
        self.title = title
        self.type = "info"
        self.info = info
        self.cancelText = cancelText
        self.cancel = cancel
        self.isAlert = true
    }
}