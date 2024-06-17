//
//  SearchDetailViewModelProtocol.swift
//  FlickrSearch
//
//  Created by Nimish Sharma on 6/16/24.
//

import Foundation

protocol SearchDetailViewModelProtocol: ObservableObject {
    var viewState: SearchDetailViewState<SearchResultItem> { get set }
}
