//
// Created by 强子 on 2021/8/7.
//

//
// Created by 强子 on 2020/12/28.
//

import Foundation
import Alamofire
import CleanJSON

struct AppVersionApi{


    static func getCurrentVersion() -> AppVersion{
        let infoDic = Bundle.main.infoDictionary!
        let  majorVersion: String = infoDic["CFBundleShortVersionString"] as! String
        return AppVersion(version: majorVersion)
    }

    static var currentVersionString: String {
        getCurrentVersion().version()
    }

    static func getLatestVersion(bundle: String, cb:@escaping (AppVersion) -> Void) {
        var URL: String {
            "https://itunes.apple.com/lookup?bundleId=" + bundle + "&v=\(MyDateUtil.getCurrentMilliTimeStamp())"
        }
        Alamofire.AF.request(URL).responseString { resp in
            let decoder = CleanJSONDecoder()
            guard let data = resp.value else {
                return
            }
            let rst = try! decoder.decode(AppVersionResult.self, from: data.data(using: .utf8)!)
            guard let rr = rst.results.max(by: { (x, y) -> Bool in
                !x.toAppVersion().largeThan(other: y.toAppVersion())
            }) else{
                return
            }
            cb(rr.toAppVersion())
        }
    }
}

struct AppVersion: Codable {
    var majorVersion: Int = 0
    var minorVersion: Int = 0
    var bugVersion: Int = 0
    var build: Int = 0

    init(){

    }

    init(version: String){
        let rs = version.split(separator: ".")
        self.majorVersion = Int(rs[0])!
        self.minorVersion = Int(rs[1])!
        if(rs.count > 2){
            self.bugVersion = Int(rs[2])!
        }
    }

    func largeThan(other: AppVersion) -> Bool {
        let v1 = (self.majorVersion * 10000).toFloat() + self.minorVersion.toFloat()  + (self.bugVersion.toDouble() / 10000.0).toFloat()
        let v2 = (other.majorVersion * 10000).toFloat() + other.minorVersion.toFloat() + (other.bugVersion.toDouble() / 10000.0).toFloat()
        return v1 > v2
    }

    func version() -> String {
        "v\(self.majorVersion).\(self.minorVersion).\(self.bugVersion)"
    }

    static func compareName(latestVersion: AppVersion) -> String {
        if(latestVersion.largeThan(other: AppVersionApi.getCurrentVersion())){
            return "有新版本\(latestVersion.version())"
        }
        else{
            return AppVersionApi.getCurrentVersion().version()
        }
    }

    static func hasNewVersion(latestVersion: AppVersion) -> Bool {
        latestVersion.largeThan(other: AppVersionApi.getCurrentVersion())
    }
}

struct AppVersionResult: Codable {

    var resultCount: String = ""
    var results: [AppVersionDetail]

    struct AppVersionDetail: Codable {
        var version: String = ""

        func toAppVersion() -> AppVersion {
            AppVersion(version: version)
        }
    }
}
