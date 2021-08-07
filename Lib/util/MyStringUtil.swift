//
// Created by 李和 on 2021/8/5.
//

import Foundation

extension String {

    func slice(begin: Int, end: Int) -> String {
        var str = self
        var _end = end
        let beginIndex = str.index(str.startIndex, offsetBy: begin)
        if(end < 0){
            _end = str.count + end
        }
        if(_end > str.count){
            _end = str.count
        }
        let endIndex = str.index(str.startIndex, offsetBy: _end)
        if(begin > _end){
            return ""
        }
        return String(str[beginIndex..<endIndex])
    }

    func slice(begin: Int, len: Int) -> String {
        self.slice(begin: begin, end: begin + len)
    }

    func slice(begin: Int) -> String {
        self.slice(begin: begin, end: self.count)
    }

    func toInt() -> Int {
        guard let x = Int(self) else {
            return -1
        }
        return x
    }

    func toDouble() -> Double {
        guard let x = Double(self) else {
            return -1
        }
        return x
    }

}

