////
//// Created by 强子 on 2021/10/6.
////
//
import SwiftUI
import WebKit
import QzLib

//
//extension WKWebView {
//
//    private var httpCookieStore: WKHTTPCookieStore  { return WKWebsiteDataStore.default().httpCookieStore }
//
//    public func getCookies(for domain: String? = nil, completion: @escaping ([String : Any])->())  {
//        var cookieDict = [String : AnyObject]()
//        httpCookieStore.getAllCookies { cookies in
//            for cookie in cookies {
//                if let domain = domain {
//                    if cookie.domain.contains(domain) {
//                        cookieDict[cookie.name] = cookie.properties as AnyObject?
//                    }
//                } else {
//                    cookieDict[cookie.name] = cookie.properties as AnyObject?
//                }
//            }
//            completion(cookieDict)
//        }
//    }
//
//    public func cleanAllCookies() {
//        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
//        ps("All cookies deleted")
//
//        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
//            records.forEach { record in
//                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
//                ps("Cookie ::: \(record) deleted")
//            }
//        }
//    }
//}
//

public struct SimpleWebView: UIViewRepresentable {

    public  var webview: WKWebView?
    public  var request: URLRequest


    public func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    public var url: String
    public var onEnd: (() -> Void)?

    public var onError: (() -> Void)?

    public init(url: String,cleanCookie: Bool = false, onEnd: (() -> Void)? = nil, onError: (() -> Void)? = nil) {
        self.url = url
        self.onEnd = onEnd
        self.onError = onError
        self.request = URLRequest(url: URL(string: url)!)


        var s1 = MyHtmlUtil.loadCssScript(cssFileName: "doc")
        let contentController = WKUserContentController()
        let script = WKUserScript(source: s1, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        contentController.addUserScript(script)

        let config = WKWebViewConfiguration()
        config.userContentController = contentController

        self.webview = WKWebView(frame: .zero, configuration: config)



//        self.webview = WKWebView()
//        let config: WKWebViewConfiguration = webview!.configuration
//        let userContentController = config.userContentController
//        userContentController.addUserScript(WKUserScript(source: MyHtmlUtil.getLogScript(), injectionTime: .atDocumentStart, forMainFrameOnly: false))
//        userContentController.addUserScript(WKUserScript(source: MyHtmlUtil.loadCssScript(cssFileName: "doc"), injectionTime: .atDocumentEnd, forMainFrameOnly: false))
//        userContentController.addUserScript(WKUserScript(source: "alert('yes')", injectionTime: .atDocumentEnd, forMainFrameOnly: false))


    }

    public func makeUIView(context: Context) -> WKWebView {
        webview!.navigationDelegate = context.coordinator
        webview!.load(self.request)
        return webview!
    }

    public func updateUIView(_ uiView: WKWebView, context: Context) {

    }

    public func load(url: String) {
        webview?.load(URLRequest(url: URL(string: url)!))
    }

    public func clear() {

    }

    public func reload() {
        webview?.reload()
    }

    public class Coordinator: NSObject, WKNavigationDelegate {

        public var parent: SimpleWebView

        public  init(parent: SimpleWebView) {
            self.parent = parent
            super.init()
        }

        public func executeJs(_ webview: WKWebView, jslist: [String], idx: Int, cb: @escaping () -> Void) {
            if(idx == jslist.count){
                return cb()
            }
            webview.evaluateJavaScript(jslist[idx]){ (_, error) in
                if(error != nil){
                    ps(error)
                }
                self.executeJs(webview, jslist: jslist, idx: idx+1, cb: cb)
            }
        }

        public func getRemoveNodeScript(selector: String) -> String {
            "document.querySelector(\"\(selector)\").remove()"
        }

        public func appendRemoveNode(jslist:inout [String], selector: String) {
            jslist.append(getRemoveNodeScript(selector: selector))
        }

        public func appendScript(jslist:inout [String], script: String) {
            jslist.append(script)
        }

        public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            var jslist: [String] = []


            jslist.append("console.log(document.documentElement.innerHTML)")

            appendRemoveNode(jslist: &jslist, selector: "[data-testid='h5-doc-reader-login-card']")
            appendRemoveNode(jslist: &jslist, selector: "[class^='H5DocReader-module_topOnboardingBanner']")
            appendRemoveNode(jslist: &jslist, selector: "[class^='like-module_larkLike']")
            appendRemoveNode(jslist: &jslist, selector: ".m-doc-comments")
            appendRemoveNode(jslist: &jslist, selector: "[class^='H5DocReader-module_toolbar']")
            appendRemoveNode(jslist: &jslist, selector: ".doc-contributors")
            appendRemoveNode(jslist: &jslist, selector: "[class^='H5DocReader-module_meta']")
            appendRemoveNode(jslist: &jslist, selector: "[data-testid='h5-page-toolbar']")

            executeJs(webView, jslist: jslist, idx: 0) {
                DispatchQueue.main.async {
                    self.parent.onEnd?()
                }
            }
        }


        public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> ()) {

            if navigationAction.navigationType == .linkActivated {
                decisionHandler(.allow)
//                guard let newUrl = navigationAction.request.url else {
//                    return
//                }
//                NavigationUtil.open(url: newUrl) {
//                    ps("cancel page")
//                    decisionHandler(.cancel)
//                }
            } else {
//                ps("allow2")
                decisionHandler(.allow)
            }
        }

        public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            ps("网址无法访问")
        }

        public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            ps("network error")
            self.parent.onError?()
        }
    }

}
