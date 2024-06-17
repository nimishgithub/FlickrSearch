//
//  SearchRespositoryProtocol.swift
//  FlickrSearch
//
//  Created by Nimish Sharma on 6/15/24.
//

import Foundation
import Combine

protocol SearchRespositoryProtocol {
    func getImages(query: String) -> AnyPublisher<[SearchResultItem], Error>
}
