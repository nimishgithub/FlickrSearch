//
//  SearchDetailViewState.swift
//  FlickrSearch
//
//  Created by Nimish Sharma on 6/16/24.
//

import Foundation

enum SearchDetailViewState<Data>: ViewState {
    typealias Data = SearchResultItem
    case loaded(Data)
}
