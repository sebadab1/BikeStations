//
//  BikeStationMapper.swift
//  BikeStations
//
//  Created by Sebastian Dąbrowski on 17.04.2024.
//

import Foundation

protocol BikeStationMapper {
    func map(container: BikeStationInfoContainerDto) -> [BikeStationInfo]
}

class BikeStationMapperImpl: BikeStationMapper {
    func map(container: BikeStationInfoContainerDto) -> [BikeStationInfo] {
        return container
            .data
            .stations
            .map { dto in
                BikeStationInfo(
                    identifier: dto.identifier ?? "",
                    name: dto.name ?? "",
                    address: dto.address ?? "",
                    latitude: dto.latitude ?? 0,
                    longitude: dto.longitude ?? 0
                )
            }
    }
}
