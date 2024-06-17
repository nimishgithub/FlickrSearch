//
//  NetworkManager.swift
//  Mealz
//
//  Created by Nimish Sharma on 1/17/24.
//

import Foundation
import Combine

final class NetworkingManager: NetworkingServiceProtocol {
    
    static let shared = NetworkingManager()
    
    private init() { }
    
    func get<T: Decodable>(endpoint: EndPoint) -> AnyPublisher<T, NetworkingError> {
        guard let url = endpoint.url else {
            return Fail(error: NetworkingError.unknownError).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .mapError { NetworkingError.urlError($0) }
            .flatMap { data -> AnyPublisher<T, NetworkingError> in
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                return Just(data)
                    .decode(type: T.self, decoder: decoder)
                    .mapError { error in
                        if let decodingError = error as? DecodingError {
                            return NetworkingError.decodingError(decodingError)
                        } else {
                            return NetworkingError.unknownError
                        }
                    }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

enum NetworkingError: LocalizedError {
    case urlError(URLError)
    case decodingError(DecodingError)
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .urlError(let error):
            return error.localizedDescription
        case .decodingError(let error):
            return error.localizedDescription
        case .unknownError:
            return "An unknown error occurred."
        }
    }
}
