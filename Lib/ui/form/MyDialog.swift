//
// Created by 强子 on 2022/1/9.
//

import SwiftUI
import QzLib

public class DialogManager: ObservableObject {


    @Published public var showTimeChooseDialog: Bool = false
    @Published public var defaultTime: String = ""

    public var title: String = ""
    public var action: ((String) -> Void)? = nil
    public var cancel: (() -> Void)? = nil

    public init() {

    }

    public func showTimeChoose(title: String, time: String, cb:@escaping (String) -> Void){
        self.title = title
        self.showTimeChooseDialog = true
        self.defaultTime = time
        self.action = cb
    }
}
