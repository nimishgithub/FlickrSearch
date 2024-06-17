//
//  SearchViewModelProtocol.swift
//  FlickrSearch
//
//  Created by Nimish Sharma on 6/15/24.
//

import Foundation

protocol SearchViewModelProtocol: ObservableObject {
    var searchString: String { get set }
    var viewState: SearchViewState<[SearchResultItem]> { get set }
}
