//
// Created by 强子 on 2021/8/7.
//

//
// Created by 强子 on 2020/12/28.
//

import Foundation
import Alamofire
import CleanJSON
import QzLib

public struct AppVersionApi{


    public static func  getCurrentVersion() -> AppVersion{
        let infoDic = Bundle.main.infoDictionary!
        let  majorVersion: String = infoDic["CFBundleShortVersionString"] as! String
        return AppVersion(version: majorVersion)
    }

    static var currentVersionString: String {
        getCurrentVersion().version()
    }

    public static func  getLatestVersion(bundle: String, cb:@escaping (AppVersion) -> Void) {
        var URL: String {
            "https://itunes.apple.com/lookup?bundleId=" + bundle + "&v=\(MyDateUtil.getCurrentMilliTimeStamp())"
        }
        Alamofire.AF.request(URL).responseString { resp in
            let decoder = CleanJSONDecoder()
            guard let data = resp.value else {
                return
            }
            guard let mdata = data.data(using: .utf8) else {
                return
            }
            let rst = try? decoder.decode(AppVersionResult.self, from: mdata)
            if(rst != nil){
                guard let rr = rst!.results.max(by: { (x, y) -> Bool in
                    !x.toAppVersion().largeThan(other: y.toAppVersion())
                }) else{
                    return
                }
                cb(rr.toAppVersion())
            }
            else{
                ps("error2")
            }
        }
    }
}

public struct AppVersion: Codable {
    var majorVersion: Int = 0
    var minorVersion: Int = 0
    public var bugVersion: Int = 0
    var build: Int = 0

    public init(){

    }

    public init(version: String){
        let rs = version.split(separator: ".")
        self.majorVersion = Int(rs[0])!
        self.minorVersion = Int(rs[1])!
        if(rs.count > 2){
            self.bugVersion = Int(rs[2])!
        }
    }

    public func largeThan(other: AppVersion) -> Bool {
        let v1 = (self.majorVersion * 10000).toFloat() + self.minorVersion.toFloat()  + (self.bugVersion.toDouble() / 10000.0).toFloat()
        let v2 = (other.majorVersion * 10000).toFloat() + other.minorVersion.toFloat() + (other.bugVersion.toDouble() / 10000.0).toFloat()
        return v1 > v2
    }

    public func importVersionLargeThan(other: AppVersion) -> Bool {
        return self.majorVersion > other.majorVersion
    }

    public func version() -> String {
        "v\(self.majorVersion).\(self.minorVersion).\(self.bugVersion)"
    }

    public static func compareName(latestVersion: AppVersion) -> String {
        if(latestVersion.largeThan(other: AppVersionApi.getCurrentVersion())){
            return "有新版本\(latestVersion.version())"
        }
        else{
            return AppVersionApi.getCurrentVersion().version()
        }
    }

    public static func hasNewVersion(latestVersion: AppVersion) -> Bool {
        latestVersion.largeThan(other: AppVersionApi.getCurrentVersion())
    }
}

public struct AppVersionResult: Codable {

    public var resultCount: String = ""
    public var results: [AppVersionDetail]

    public struct AppVersionDetail: Codable {
        var version: String = ""

        public func toAppVersion() -> AppVersion {
            AppVersion(version: version)
        }
    }
}
