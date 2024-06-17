//
//  SearchDetailView.swift
//  FlickrSearch
//
//  Created by Nimish Sharma on 6/15/24.
//

import SwiftUI
import DesignSystem

private struct Constants {
    struct ViewDimensions {
        static let titleImageHeight: CGFloat = 250
        static let titleImageCornerRadius: CGFloat = 10
    }

    struct UITexts {
        static let dimensions = "Dimensions"
        static let tags = "Tags"
    }

    struct AccessibilityTexts {
        static let image = "Image"
        static let doubleTapToSeeVoiceOver = "Double-tap to see detail screen"
        static let dimensions = "Dimensions"
        static let tagsCollection = "Tags Collection"
    }
}

struct SearchDetailView<ViewModel: SearchDetailViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    @State private var showingShareSheet = false
    
    var body: some View {
        ScrollView {
            switch viewModel.viewState {
            case let .loaded(viewState):
                VStack {
                    AsyncImageView(urlString: viewState.media.m)
                        .frame(height: Constants.ViewDimensions.titleImageHeight)
                        .cornerRadius(Constants.ViewDimensions.titleImageCornerRadius)
                        .clipped()
                        .accessibilityConfig(
                            label: "\(viewState.title) \(Constants.AccessibilityTexts.image)"
                        )
                    dimensionView(viewState)
                    tagView(viewState)
                }
                .padding()
                .navigationTitle(viewState.title.capitalized)
                .ifLet(URL(string: viewState.link)) { (view, shareUrl) in
                    view.toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            ShareLink(item: shareUrl) {
                                Image(systemName: "square.and.arrow.up")
                            }
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func dimensionView(_ viewState: SearchResultItem) -> some View {
        if let dimensions = viewState.extractedImageSize(from: viewState.description) {
            HStack {
                Text(Constants.UITexts.dimensions + ": \t\(dimensions.width) x \(dimensions.height)")
                    .font(.title)
                    .fontWeight(.semibold)
                    .accessibilityConfig(
                        label: "\(Constants.AccessibilityTexts.dimensions), \(dimensions.width) by \(dimensions.height)"
                    )
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    private func tagView(_ viewState: SearchResultItem) -> some View {
        let items = viewState.tags
            .components(separatedBy: " ")
            .map {
                TagViewItem(title: $0.capitalized, isSelected: false)
            }
        HStack {
            Text(Constants.UITexts.tags + ":")
                .font(.title)
                .fontWeight(.semibold)
                .accessibilityConfig(
                    label: Constants.AccessibilityTexts.tagsCollection
                )
            Spacer()
        }
        TagView(tags: items)
    }
}
