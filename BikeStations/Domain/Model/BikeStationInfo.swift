//
//  BikeStationInfo.swift
//  BikeStations
//
//  Created by Sebastian Dąbrowski on 18.04.2024.
//

import Foundation

struct BikeStationInfo: Hashable {
    let identifier: String
    let name: String
    let address: String
    let latitude: Double
    let longitude: Double
}
