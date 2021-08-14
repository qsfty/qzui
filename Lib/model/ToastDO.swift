//
// Created by 强子 on 2021/8/7.
//

import Foundation

public struct ToastDO{

    public var success: Bool = true
    public var message: String = ""
    public var sheet: Bool = false
    public var show: Bool = false

    public init(){}

    public static func success(_ message: String) -> ToastDO{
        var toastDO = ToastDO()
        toastDO.success = true
        toastDO.show = true
        toastDO.message = message
        return toastDO
    }

    public static func error(_ message: String) -> ToastDO{
        var toastDO = ToastDO()
        toastDO.success = false
        toastDO.show = true
        toastDO.message = message
        return toastDO
    }

    public static func sheetSuccess(_ message: String) -> ToastDO{
        var toastDO = success(message)
        toastDO.sheet = true
        return toastDO
    }

    public static func sheetError(_ message: String) -> ToastDO{
        var toastDO = error(message)
        toastDO.sheet = true
        return toastDO
    }
}