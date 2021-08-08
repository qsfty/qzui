//
// Created by 强子 on 2021/8/7.
//

import Foundation


public struct SelectDO: Codable, Equatable{
    public static func ==(lhs: SelectDO, rhs: SelectDO) -> Bool {
        lhs.label == rhs.label && lhs.value == rhs.value
    }

    public var label: String
    public var value: String
}



extension SelectDO {

    public static func initValues(_ args: String...) -> [SelectDO] {
        var result: [SelectDO] = []
        for i in 0..<args.count / 2 {
            if(i * 2 + 1 < args.count){
                result.append(SelectDO(label: args[i * 2], value: args[i * 2 + 1]))
            }
        }
        return result
    }
}

