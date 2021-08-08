//
// Created by 强子 on 2021/8/7.
//

import SwiftUI

/**
 * 网络连接失败视图
 */
public struct NetworkErrorView: View {

     public var body: some View {
        HStack{
            Spacer()
            VStack{
                Image(systemName: "wifi.exclamationmark").foregroundColor(Color.gray).font(.system(size: 50)).padding()
                Text("网络连接失败").foregroundColor(Color.gray).font(.system(size: 14))
            }
            Spacer()
        }.padding(.top, 100)
    }
}
