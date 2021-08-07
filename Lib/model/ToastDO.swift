//
// Created by 强子 on 2021/8/7.
//

import Foundation

struct ToastDO{

    var success: Bool = true
    var message: String = ""
    var sheet: Bool = false
    var show: Bool = false

    static func success(_ message: String) -> ToastDO{
        var toastDO = ToastDO()
        toastDO.success = true
        toastDO.show = true
        toastDO.message = message
        return toastDO
    }

    static func error(_ message: String) -> ToastDO{
        var toastDO = ToastDO()
        toastDO.success = false
        toastDO.show = true
        toastDO.message = message
        return toastDO
    }

    static func sheetSuccess(_ message: String) -> ToastDO{
        var toastDO = success(message)
        toastDO.sheet = true
        return toastDO
    }

    static func sheetError(_ message: String) -> ToastDO{
        var toastDO = error(message)
        toastDO.sheet = true
        return toastDO
    }
}