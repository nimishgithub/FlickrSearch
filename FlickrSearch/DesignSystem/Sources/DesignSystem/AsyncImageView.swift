//
//  TagView.swift
//
//
//  Created by Nimish Sharma on 6/15/24.
//

import SwiftUI

public struct AsyncImageView: View {
    private let urlString: String
    
    public init(urlString: String) {
        self.urlString = urlString
    }
    
    public var body: some View {
        GeometryReader { proxy in
            let availableHeight = proxy.size.height
            let availableWidth = proxy.size.width
            if let photoURL = URL(string: urlString) {
                AsyncImage(url: photoURL) { phase in
                    switch phase {
                    case .empty:
                        ZStack(alignment: .center) {
                            ProgressView()
                        }
                        .frame(width: availableWidth,
                               height: availableHeight)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: availableWidth,
                                   height: availableHeight)
                    case .failure:
                        Image("brokenImage")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: availableWidth,
                                   height: availableHeight)
                    @unknown default:
                        EmptyView()
                    }
                }
            }
        }
    }
}
