//
//  SearchApiService.swift
//  FlickrSearch
//
//  Created by Nimish Sharma on 6/15/24.
//

import Foundation
import Combine

final class SearchApiService: SearchApiServiceProtocol {
    private let networkingService: NetworkingServiceProtocol
    
    init(networkingService: NetworkingServiceProtocol = NetworkingManager.shared) {
        self.networkingService = networkingService
    }
    
    func searchImages(query: String) -> AnyPublisher<SearchApiResponse, NetworkingError> {
        networkingService.get(endpoint: SearchImagesEndPoint(searchQuery: query))
    }
}
