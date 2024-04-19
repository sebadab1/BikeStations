//
//  BikeStationStatusRepositoryImpl.swift
//  BikeStations
//
//  Created by Sebastian Dąbrowski on 18.04.2024.
//

import Foundation
import Combine

final class BikeStationStatusRepositoryImpl: BikeStationStatusRepository {
    @Injected var apiClient: APIClient
    @Injected var bikeStationStatusMapper: BikeStationStatusMapper

    func getStatus() -> AnyPublisher<[BikeStationStatus], Error> {
        apiClient
            .makeRequest(.status, type: BikeStationStatusContainerDto.self)
            .map { [weak self] dto in
                guard let self else {
                    return []
                }

                return bikeStationStatusMapper.map(container: dto)
            }
            .eraseToAnyPublisher()
    }
}
