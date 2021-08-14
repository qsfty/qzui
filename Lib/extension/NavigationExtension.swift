//
// Created by 强子 on 2021/8/7.
//


import SwiftUI
public var openGesture = true

extension UINavigationController: UIGestureRecognizerDelegate {
     override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        viewControllers.count > 1 && openGesture
    }



}
