//
//  GridView.swift
//  
//
//  Created by Nimish Sharma on 6/15/24.
//

import SwiftUI

public struct GridView<Item: Identifiable, Content: View>: View {
    private let items: [Item]
    private let content: (Item) -> Content
    private let spacing: CGFloat
    private let parentSize: CGSize
    private let cellMinWidth: CGFloat
    
    public init(_ items: [Item],
         parentSize: CGSize,
         spacing: CGFloat,
         cellMinWidth: CGFloat,
         @ViewBuilder content: @escaping (Item) -> Content)
    {
        self.items = items
        self.parentSize = parentSize
        self.spacing = spacing
        self.cellMinWidth = cellMinWidth
        self.content = content
    }
    
    public var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: cellMinWidth))],
                      spacing: spacing) {
                ForEach(items, id: \.id) { item in
                    content(item)
                }
            }
            .padding()
        }
    }
}
