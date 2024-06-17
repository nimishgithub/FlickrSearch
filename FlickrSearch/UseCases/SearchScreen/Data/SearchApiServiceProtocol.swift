//
//  SearchApiServiceProtocol.swift
//  FlickrSearch
//
//  Created by Nimish Sharma on 6/15/24.
//

import Foundation
import Combine

protocol SearchApiServiceProtocol {
    func searchImages(query: String) -> AnyPublisher<SearchApiResponse, NetworkingError>
}
