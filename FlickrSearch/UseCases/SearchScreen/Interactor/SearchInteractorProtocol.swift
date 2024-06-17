//
//  SearchInteractorProtocol.swift
//  FlickrSearch
//
//  Created by Nimish Sharma on 6/15/24.
//

import Foundation
import Combine

protocol SearchInteractorProtocol {
    func searchImages(query: String) -> AnyPublisher<SearchViewState<[SearchResultItem]>, Never>
}
