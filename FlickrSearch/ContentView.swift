//
//  ContentView.swift
//  FlickrSearch
//
//  Created by Nimish Sharma on 6/15/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        SearchView(
            viewModel: SearchViewModel(
                searchInteractor: SearchInteractor(
                    searchRepository: SearchRepository(
                        searchApiService: SearchApiService()
                    )
                )
            )
        )
    }
}

#Preview {
    ContentView()
}
