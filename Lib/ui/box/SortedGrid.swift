//
// Created by 强子 on 2022/1/29.
//

import SwiftUI
import UIKit
import UniformTypeIdentifiers


public struct SortedGrid<Content: View, Item: Identifiable & Equatable>: View {

    let column: Int = 3
    let items: [Item]
    let content: (Item) -> Content
    let moveAction: (IndexSet, Int) -> Void

    // A little hack that is needed in order to make view back opaque
    // if the drag and drop hasn't ever changed the position
    // Without this hack the item remains semi-transparent
    @State private var hasChangedLocation: Bool = false

    var columns: [GridItem]

    public init(
            items: [Item],
            column: Int = 3,
            @ViewBuilder content: @escaping (Item) -> Content,
            moveAction: @escaping (IndexSet, Int) -> Void
    ) {
        self.columns = []
        for i in 0..<column {
            self.columns.append(GridItem(.flexible()))
        }
        self.items = items
        self.content = content
        self.moveAction = moveAction
    }

    @State private var draggingItem: Item?

    public var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(items) { item in
                content(item)
//                        .overlay(draggingItem == item && hasChangedLocation ? Color.white.opacity(0.8) : Color.clear)
                        .onDrag {
                            draggingItem = item
                            return NSItemProvider(object: "\(item.id)" as NSString)
                        }
                        .onDrop(
                                of: [UTType.text],
                                delegate: DragRelocateDelegate(
                                        item: item,
                                        listData: items,
                                        current: $draggingItem,
                                        hasChangedLocation: $hasChangedLocation
                                ) { from, to in
                                    withAnimation {
                                        moveAction(from, to)
                                    }
                                }
                        )
            }
        }
    }

}



struct DragRelocateDelegate<Item: Equatable>: DropDelegate {
    let item: Item
    var listData: [Item]
    @Binding var current: Item?
    @Binding var hasChangedLocation: Bool

    var moveAction: (IndexSet, Int) -> Void

    func dropEntered(info: DropInfo) {
        guard item != current, let current = current else { return }
        guard let from = listData.firstIndex(of: current), let to = listData.firstIndex(of: item) else { return }

        hasChangedLocation = true

        if listData[to] != current {
            moveAction(IndexSet(integer: from), to > from ? to + 1 : to)
        }
    }

    func dropUpdated(info: DropInfo) -> DropProposal? {
        DropProposal(operation: .move)
    }

    func performDrop(info: DropInfo) -> Bool {
        hasChangedLocation = false
        current = nil
        return true
    }
}

