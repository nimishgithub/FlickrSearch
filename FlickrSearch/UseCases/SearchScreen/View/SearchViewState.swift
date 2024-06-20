//
//  ViewState.swift
//  FlickrSearch
//
//  Created by Nimish Sharma on 6/15/24.
//

import Foundation

protocol ViewState {
    associatedtype Data
}

enum SearchViewState<Data>: ViewState {
    typealias Data = Data
    case loading
    case loaded(Data)
    case error(Error)
}
