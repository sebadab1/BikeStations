//
//  BikeStationStatus.swift
//  BikeStations
//
//  Created by Sebastian Dąbrowski on 18.04.2024.
//

import Foundation

struct BikeStationStatus: Hashable {
    let identifier: String
    let availableBikes: Int
    let availablePlaces: Int
}
