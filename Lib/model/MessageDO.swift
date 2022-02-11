//
// Created by 强子 on 2022/1/27.
//


import Foundation

public struct MessageDO{

    public var error: Bool = false
    public var messsage: String = ""

    public init(){

    }

    public init(message: String){
        self.error = true
        self.messsage = message
    }

    init(error: Bool){
        self.error = error
        messsage = ""
    }

    public static func success() -> MessageDO{
        MessageDO(error: false)
    }

    public static func error(_ message: String) -> MessageDO{
        MessageDO(message: message)
    }
}
