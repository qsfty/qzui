//
// Created by 强子 on 2022/1/30.
//


import SwiftUI
import Combine
import QzLib

public struct AdaptsToKeyboard: ViewModifier {
    @State var currentHeight: CGFloat = 0

    public func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                    .padding(.bottom, self.currentHeight)
                    .onAppear(perform: {
                        NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillShowNotification)
                                .merge(with: NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillChangeFrameNotification))
                                .compactMap { notification in
                                    withAnimation(.easeOut(duration: 0.16)) {
                                        notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
                                    }
                                }
                                .map { rect in
                                    rect.height - geometry.safeAreaInsets.bottom
                                }
                                .subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))

                        NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillHideNotification)
                                .compactMap { notification in
                                    return CGFloat.zero
                                }
                                .subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))
                    })
        }
    }
}

extension View {
    public func adaptsToKeyboard() -> some View {
        return modifier(AdaptsToKeyboard())
    }
}