//
// Created by 强子 on 2021/8/7.
//

import SwiftUI


public struct FollowButton : View {

    public var followed: Bool
    public var type: String = "关注"
    public var size: SizeType = .small
    public var action: () -> Void

    public func horizontalPadding() -> CGFloat {
        switch size {
        case .small:
            return 8.toFloat()
        case .normal:
            return 12.toFloat()
        case .large:
            return 20.toFloat()
        default:
            return 8.toFloat()
        }
    }
    public func verticalPadding() -> CGFloat {
        switch size {
        case .small:
            return 5.toFloat()
        case .normal:
            return 7.toFloat()
        case .large:
            return 9.toFloat()
        default:
            return 5.toFloat()
        }
    }

    public var body: some View {

        VStack {
            Text(self.followed ? "取消\(type)" : type)
                    .fontSize(size.rawValue)
                    .foregroundColor(Color.white)
                    .padding(.horizontal, horizontalPadding())
                    .padding(.vertical, verticalPadding())
                    .bg(followed ? "gray" : "gray")
                    .cornerRadius(4).highTap {
                        self.action()
                    }
        }
    }
}
