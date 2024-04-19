//
//  APIClient.swift
//  BikeStations
//
//  Created by Sebastian Dąbrowski on 17.04.2024.
//

import Foundation
import Combine

enum APIClientError: Error {
    case invalidURL
    case invalidRequest
}

protocol Client {
    func makeRequest<T: Codable>(_ endpoint: Endpoint, type _: T.Type) -> AnyPublisher<T, Error>
}

class APIClient: Client {
    func makeRequest<T: Codable>(_ endpoint: Endpoint, type _: T.Type) -> AnyPublisher<T, Error> {
        guard let url = URL(string: endpoint.path) else {
            return Fail(error: APIClientError.invalidURL)
                .eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue

        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw APIClientError.invalidRequest
                }

                return try JSONDecoder().decode(T.self, from: data)
            }
            .eraseToAnyPublisher()
    }
}
