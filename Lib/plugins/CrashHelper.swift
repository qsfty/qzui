//
// Created by 强子 on 2021/10/6.
//

import QzLib

public struct CrashHelper {

    static let KEY = "crash_log"

    static func setCrashLog(_ body: String){
        MyCacheUtil.set(KEY, value: body)
    }

    public static func getAndClean() -> String {
        let data = MyCacheUtil.get(KEY)
        if(data != ""){
            MyCacheUtil.remove(KEY)
        }
        return data
    }
}