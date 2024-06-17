//
//  TagView.swift
//  EventApp
//
//  Created by Ahmadreza on 10/15/21.
//  Copyright © 2021 Alexani. All rights reserved.
//

// Source: https://github.com/HappyIosDeveloper/SwiftUI-TagView/blob/main/TagView.swift

import SwiftUI

public struct TagViewItem: Hashable {
    
    public var title: String
    public var isSelected: Bool
    
    public init(title: String, isSelected: Bool) {
        self.title = title
        self.isSelected = isSelected
    }
    
    public static func == (lhs: TagViewItem, rhs: TagViewItem) -> Bool {
        return lhs.isSelected == rhs.isSelected
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(isSelected)
    }
}

public struct TagView: View {
    @State var tags: [TagViewItem]
    @State private var totalHeight = CGFloat.zero
    
    public init(tags: [TagViewItem], totalHeight: CGFloat = CGFloat.zero) {
        self.tags = tags
        self.totalHeight = totalHeight
    }
    
    public var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        return ZStack(alignment: .topLeading) {
            ForEach(Array(tags.enumerated()), id: \.offset) { (offset, tag) in
                item(for: tag.title, isSelected: tag.isSelected)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width) {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tag.title == self.tags.last!.title {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if tag.title == self.tags.last!.title {
                            height = 0 // last item
                        }
                        return result
                    }).onTapGesture {
                        tags[offset].isSelected.toggle()
                    }
            }
        }.background(viewHeightReader($totalHeight))
    }

    private func item(for text: String, isSelected: Bool) -> some View {
        Text(text)
            .foregroundColor(isSelected ? .white : .secondary)
            .padding()
            .lineLimit(1)
            .background(isSelected ? Color.blue : Color.gray.opacity(0.3))
            .frame(height: 36)
            .cornerRadius(5)
    }

    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}
