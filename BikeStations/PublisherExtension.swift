//
//  PublisherExtension.swift
//  BikeStations
//
//  Created by Sebastian Dąbrowski on 17.04.2024.
//

import Foundation
import Combine

extension Publisher {
    func materialize() -> AnyPublisher<Result<Output, Failure>, Never> {
        return map(Result.success)
            .catch { Just(.failure($0)) }
            .eraseToAnyPublisher()
    }
}
