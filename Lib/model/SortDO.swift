//
// Created by 强子 on 2022/1/30.
//

import Foundation

public struct SortDO: Codable, Equatable, Identifiable {

    public var id: UUID = UUID()
    public var name: String = ""

    public init(name: String) {
        self.name = name
    }
}