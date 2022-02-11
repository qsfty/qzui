//
// Created by 强子 on 2021/10/6.
//

import SwiftUI

public struct MyNavUtil {


//
//    static func openWithMessage(url: URL,appStore: AppStore, errorMessage:String = ""){
//        open(url: url){
//            appStore.toast(errorMessage)
//        }
//    }

    public static func open(url: URL, complete: (() -> Void)? = nil) {
        let k = try? UIApplication.shared.canOpenURL(url)
        if (k != nil) {
            UIApplication.shared.open(url, completionHandler: { success in
                if (complete != nil) {
                    complete!()
                }
            })
        } else {
            if (complete != nil) {
                complete!()
            }
        }
    }

    public static func openLink(link: String) {
        let url = URL(string: link)!
        open(url: url)
    }


    public static func canOpenLink(link: String, complete: @escaping (Bool) -> Void) {
        guard let url = URL(string: link) else {
            complete(false)
            return
        }
        let k = try? UIApplication.shared.canOpenURL(url)
        if (k == nil) {
            complete(false)
        } else {
            complete(true)
        }

    }

}
