//
//  BikeStationStatusMapper.swift
//  BikeStations
//
//  Created by Sebastian Dąbrowski on 18.04.2024.
//

import Foundation

protocol BikeStationStatusMapper {
    func map(container: BikeStationStatusContainerDto) -> [BikeStationStatus]
}

struct BikeStationStatusMapperImpl: BikeStationStatusMapper {
    func map(container: BikeStationStatusContainerDto) -> [BikeStationStatus] {
        return container
            .data
            .stations
            .map { dto in
                BikeStationStatus(
                    identifier: dto.identifier ?? "",
                    availableBikes: dto.availableBikes ?? 0,
                    availablePlaces: dto.availablePlaces ?? 0
                )
            }
    }
}
