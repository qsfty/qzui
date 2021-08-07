//
// Created by 强子 on 2021/8/7.
//

import SwiftUI

struct KeyboardListenView: View {

    var up: ((_ height: CGFloat) -> Void)?
    var down: (() -> Void)?

    var body: some View {
        Text("").onAppear{
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: OperationQueue.current) { (noti) in
                let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                let height = value.height
                self.up?(height)
            }

            //键盘收起
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: OperationQueue.current) { (noti) in
                self.down?()
            }

        }
    }

}