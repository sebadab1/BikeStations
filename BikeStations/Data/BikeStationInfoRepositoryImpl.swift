//
//  BikeStationInfoRepositoryImpl.swift
//  BikeStations
//
//  Created by Sebastian Dąbrowski on 17.04.2024.
//

import Foundation
import Combine

class BikeStationInfoRepositoryImpl: BikeStationInfoRepository {
    @Injected var apiClient: APIClient
    @Injected var bikeStationMapper: BikeStationMapper

    func getAll() -> AnyPublisher<[BikeStationInfo], any Error> {
        apiClient
            .makeRequest(.information, type: BikeStationInfoContainerDto.self)
            .map { [weak self] dto in
                guard let self else {
                    return []
                }

                return bikeStationMapper.map(container: dto)
            }
            .eraseToAnyPublisher()
    }
}
