//
//  APIEndpoints.swift
//  FlickrSearch
//
//  Created by Nimish Sharma on 6/15/24.
//

import Foundation

protocol EndPoint {
    var methodType: APIMethodType { get set }
    var queryItems: [String: String]? { get set }
    var path: String { get set }
}

extension EndPoint {
    var host: String {
        "api.flickr.com"
    }

    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path

        var requestQueryItems: [URLQueryItem] = []

        queryItems?.forEach { item in
            requestQueryItems.append(URLQueryItem(name: item.key, value: item.value))
        }

        urlComponents.queryItems = requestQueryItems

        return urlComponents.url
    }
}

enum APIKey: String {
    case tags = "tags"
    case format = "format"
    case nojsoncallback = "nojsoncallback"
}

enum APIMethodType: String {
    case get = "GET"
}
