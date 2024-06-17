import Foundation
import Combine

final class SearchInteractor: SearchInteractorProtocol {

    private let searchRepository: SearchRespositoryProtocol

    init(searchRepository: SearchRespositoryProtocol) {
        self.searchRepository = searchRepository
    }

    func searchImages(query: String) -> AnyPublisher<SearchViewState<[SearchResultItem]>, Never> {
        guard !query.isEmpty else {
            return Just(SearchViewState.loaded([]))
                .eraseToAnyPublisher()
        }

        return searchRepository.getImages(query: query)
            .map { results in
                SearchViewState.loaded(results)
            }
            .catch { error in
                Just(SearchViewState.error(error))
            }
            .eraseToAnyPublisher()
    }
}
