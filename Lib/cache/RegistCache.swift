//
// Created by 强子 on 2021/4/30.
//

import SwiftUI

struct RegistCache{

    //是否初始化
    static let APP_INIT = "appInit"

    //注册时间
    static let REGIST_TIME = "registTime"

    static func hasRegist() -> Bool {
        return MyCacheUtil.getInt(REGIST_TIME) != 0
    }

    static func getRegistDay() -> Int {
        let registTime = MyCacheUtil.getInt(REGIST_TIME)
        let now = MyDateUtil.getCurrentTimeStamp()
        return Int(floor((now - registTime).toDouble() / 24.0 / 3600.0))
    }

    static func regist() {
        MyCacheUtil.setInt(REGIST_TIME, value: MyDateUtil.getCurrentTimeStamp())
    }

    static func tryRegist(){
        if(hasRegist()){
            return
        }
        regist()
    }

}