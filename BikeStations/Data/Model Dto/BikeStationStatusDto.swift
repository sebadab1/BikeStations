//
//  BikeStationStatusDto.swift
//  BikeStations
//
//  Created by Sebastian Dąbrowski on 18.04.2024.
//

import Foundation

struct BikeStationStatusContainerDto: Codable {
    let data: BikeStationStatusDataDto
}
struct BikeStationStatusDataDto: Codable {
    let stations: [BikeStationStatusDto]
}

struct BikeStationStatusDto: Codable {
    let identifier: String?
    let availableBikes: Int?
    let availablePlaces: Int?

    private enum CodingKeys: String, CodingKey {
        case identifier = "station_id"
        case availableBikes = "num_bikes_available"
        case availablePlaces = "num_docks_available"
    }
}
