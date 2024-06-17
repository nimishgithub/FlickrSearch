//
//  SearchImagesEndpoint.swift
//  FlickrSearch
//
//  Created by Nimish Sharma on 6/15/24.
//

import Foundation

struct SearchImagesEndPoint: EndPoint {    
    // https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=porcupine
    var path: String = "/services/feeds/photos_public.gne"
    var methodType: APIMethodType = .get
    var queryItems: [String : String]? = [
        APIKey.format.rawValue: "json",
        APIKey.nojsoncallback.rawValue: "1"
    ]

    init(searchQuery: String) {
        queryItems?[APIKey.tags.rawValue] = searchQuery
    }
}
