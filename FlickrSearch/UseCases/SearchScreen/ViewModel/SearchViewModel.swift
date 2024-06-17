//
//  FlickrSearchApp.swift
//  FlickrSearch
//
//  Created by Nimish Sharma on 6/15/24.
//
import Foundation
import Combine

final class SearchViewModel: SearchViewModelProtocol {
    private let searchInteractor: SearchInteractorProtocol

    @Published var viewState: SearchViewState<[SearchResultItem]> = .loaded([])
    @Published var searchString: String = ""

    private var cancellables = Set<AnyCancellable>()

    init(searchInteractor: SearchInteractorProtocol) {
        self.searchInteractor = searchInteractor
        self.setupSearch()
    }

    private func setupSearch() {
        $searchString
            .debounce(for: .milliseconds(100), scheduler: RunLoop.main)
            .flatMap { [unowned self] query -> AnyPublisher<SearchViewState, Never> in
                self.searchInteractor.searchImages(query: query)
                    .handleEvents(receiveSubscription: { [unowned self] _ in
                        self.viewState = .loading
                    }, receiveCompletion: { [unowned self] completion in
                        switch completion {
                        case .finished:
                            break
                        case .failure(let error):
                            self.viewState = .error(error)
                        }
                    })
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.viewState, on: self)
            .store(in: &cancellables)
    }
}
