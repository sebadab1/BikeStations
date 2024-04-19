//
//  BikeStationInfoDto.swift
//  BikeStations
//
//  Created by Sebastian Dąbrowski on 17.04.2024.
//

import Foundation

struct BikeStationInfoContainerDto: Codable {
    let data: BikeStationInfoDataDto
}

struct BikeStationInfoDataDto: Codable {
    let stations: [BikeStationInfoDto]
}

struct BikeStationInfoDto: Codable {
    let identifier: String?
    let name: String?
    let address: String?
    let latitude: Double?
    let longitude: Double?

    private enum CodingKeys: String, CodingKey {
        case identifier = "station_id"
        case name
        case address
        case latitude = "lat"
        case longitude = "lon"
    }
}
