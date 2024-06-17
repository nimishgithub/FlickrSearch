//
//  SearchRepository.swift
//  FlickrSearch
//
//  Created by Nimish Sharma on 6/15/24.
//

import Foundation
import Combine

final class SearchRepository: SearchRespositoryProtocol {
    private let searchApiService: SearchApiServiceProtocol
    
    init(searchApiService: SearchApiServiceProtocol) {
        self.searchApiService = searchApiService
    }
    
    func getImages(query: String) -> AnyPublisher<[SearchResultItem], Error> {
        searchApiService.searchImages(query: query)
            .map { (response: SearchApiResponse) in
                response.items
            }
            .mapError {
                $0 as Error
            }
            .eraseToAnyPublisher()
    }
}
