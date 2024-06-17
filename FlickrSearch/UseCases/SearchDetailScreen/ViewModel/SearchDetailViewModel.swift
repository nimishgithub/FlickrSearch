//
//  SearchDetailViewModel.swift
//  FlickrSearch
//
//  Created by Nimish Sharma on 6/16/24.
//

import Foundation

final class SearchDetailViewModel: SearchDetailViewModelProtocol {
    var viewState: SearchDetailViewState<SearchResultItem>

    init(viewState: SearchDetailViewState<SearchResultItem>) {
        self.viewState = viewState
    }
}
