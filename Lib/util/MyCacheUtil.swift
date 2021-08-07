//
// Created by 强子 on 2021/8/7.
//


import SwiftUI


class MyCacheUtil {

    static func set(_ key: String, value: String) {
        UserDefaults(suiteName: "group.cn.qsfty.schedule")?.set(value, forKey: key)
    }

    static func setInt(_ key: String, value: Int) {
        set(key, value: "\(value)")
    }

    static func set(_ key: String, module: String, value: String){
        set(mkstring(key, module: module), value: value)
    }

    static func get(_ key: String) -> String{
        guard let k = UserDefaults(suiteName: "group.cn.qsfty.schedule")?.string(forKey: key) else {
            return ""
        }
        return k
    }

    static func get(_ key: String, module: String) -> String{
        get(mkstring(key, module: module))
    }

    static func getInt(_ key: String) -> Int{
        let k = get(key)
        if(k == ""){
            return 0
        }
        return k.toInt()
    }

    static func getBoolean(_ key: String) -> Bool{
        let k = get(key)
        return k == "1"
    }

    static func setBoolean(_ key: String, value: Bool){
        set(key, value: value ? "1" : "0")
    }


    static func exist(_ key: String) -> Bool {
        get(key) != ""
    }

    static func exist(_ key: String, module: String) -> Bool {
        get(mkstring(key, module: module)) != ""
    }


    static func isConfig(_ key: String) -> Bool {
        let v = get(key)
        return v != "" && v != "0"
    }

    static func remove(_ key: String) {
        UserDefaults(suiteName: "group.cn.qsfty.schedule")?.removeObject(forKey: key)
    }

    static func remove(_ key: String, module: String) {
        UserDefaults(suiteName: "group.cn.qsfty.schedule")?.removeObject(forKey: mkstring(key, module: module))
    }

    static func setJson<T:Codable>(_ key: String,data:T) {
        set(key, value: MyJsonUtil.stringify(data: data))
    }

    static func getJsonObject<T:Codable>(_ key: String) -> T? {
        let oldData = get(key)
        if(oldData == ""){
            return nil
        }
        return MyJsonUtil.parseObject(data: oldData)
    }

    static func getJsonArray<T: Codable>(_ key: String) -> [T] {
        let oldData = get(key)
        return MyJsonUtil.parseArray(data: oldData)
    }

    static func setJson<T:Codable>(_ key: String, module: Any, data:T) {
        set(mkstring(key, module: module), value: MyJsonUtil.stringify(data: data))
    }

    static func getJsonObject<T:Codable>(_ key: String, module: Any) -> T? {
        getJsonObject(mkstring(key, module: module))
    }

    static func getJsonArray<T: Codable>(_ key: String, module: Any) -> [T] {
        getJsonArray(mkstring(key, module: module))
    }

    static func mkstring(_ key: String, module: Any) -> String{
        "\(key)___\(module)"
    }

}
