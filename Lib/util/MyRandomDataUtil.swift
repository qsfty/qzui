//
// Created by 李和 on 2021/8/4.
//

import Foundation


//随机整数
func randomNum(_ begin: Int, _ end: Int) -> Int {
    begin + Int(arc4random()) % (end - begin)
}
