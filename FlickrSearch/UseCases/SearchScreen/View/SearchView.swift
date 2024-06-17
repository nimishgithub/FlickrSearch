import SwiftUI
import DesignSystem

private struct Constants {
    struct UITexts {
        static let navigationTitle = "Flickr Search"
        static let loadingResultsText = "Loading Results..."
        static let startTypingInSearchBarText = "Start typing in the search bar above"
    }
    
    struct AccessibilityTexts {
        static let image = "Image"
        static let doubleTapToSeeVoiceOver = "Double-tap to see detail screen"
    }
}

struct SearchView<ViewModel: SearchViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.viewState {
                case .loading:
                    ProgressView(Constants.UITexts.loadingResultsText)
                        .progressViewStyle(CircularProgressViewStyle())
                case .loaded(let items):
                    if items.isEmpty {
                        searchGuideView
                    } else {
                        gridView(items)
                    }
                case .error(let error):
                    VStack {
                        Image(systemName: "chevron.left.forwardslash.chevron.right")
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        Text(error.localizedDescription)
                            .multilineTextAlignment(.center)
                            .font(.subheadline)
                    }
                }
            }
            .navigationTitle(Constants.UITexts.navigationTitle)
        }
        .searchable(text: $viewModel.searchString)
    }
    
    @ViewBuilder
    private var searchGuideView: some View {
        ZStack {
            VStack(alignment: .center) {
                Image(systemName: "arrow.up")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text(Constants.UITexts.startTypingInSearchBarText)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                Spacer()
            }
            .padding(.top, 50)
        }
    }
    
    @ViewBuilder
    private func gridView(_ dataSource: [SearchResultItem]) -> some View {
        GeometryReader { geometry in
            GridView(dataSource,
                     parentSize: geometry.size,
                     spacing: 10,
                     cellMinWidth: geometry.size.width * 0.3) { item in
                NavigationLink {
                    SearchDetailView(
                        viewModel: SearchDetailViewModel(
                            viewState: .loaded(item)
                        )
                    )
                } label: {
                    AsyncImageView(urlString: item.imageURLString)
                        .frame(height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                .accessibilityConfig(
                    label: "\(item.title) \(Constants.AccessibilityTexts.image)",
                    hint: Constants.AccessibilityTexts.doubleTapToSeeVoiceOver
                )
            }
        }
    }
}
