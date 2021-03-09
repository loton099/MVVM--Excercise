//
//  NetworkManager.swift
//  MVVM-Exercise
//
//  Created by Shakti Prakash Srichandan on 04/02/21.
//

import Foundation
import Combine

protocol NetworkFetchable {
    func getUserDetails() -> AnyPublisher<[User],MEError>
}


class NetworkFetcher {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension NetworkFetcher: NetworkFetchable {
    func getUserDetails() -> AnyPublisher<[User],MEError> {
        return performNetworkCall(with: makeJsonPlaceholderComponents())
    }
    
    private func performNetworkCall<T: Decodable>(with components: URLComponents) -> AnyPublisher<T,MEError>  {
        
        guard let url = components.url  else {
            let error = MEError.unknownError()
            return Fail(error: error).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError {  error in
                MEError.decodingError()
            }
            .map(\.data)
            .flatMap { data in
                decode(data)
            }
            .eraseToAnyPublisher()
    }
    
}



// MARK: - JsonPlaceHolder  API
private extension NetworkFetcher {
    struct JsonPlaceHolderAPI {
        static let scheme = "https"
        static let host = "jsonplaceholder.typicode.com"
        static let path = "/users"
    }
    
    func makeJsonPlaceholderComponents()-> URLComponents {
        var components = URLComponents()
        components.scheme = JsonPlaceHolderAPI.scheme
        components.host = JsonPlaceHolderAPI.host
        components.path = JsonPlaceHolderAPI.path
        return components
    }
    
}
