//
//  BikeStation.swift
//  BikeStations
//
//  Created by Sebastian Dąbrowski on 17.04.2024.
//

import Foundation

struct BikeStation: Hashable {
    let name: String
    let address: String
    let longitude: Double
    let latitude: Double
    let status: BikeStationStatus?
}
