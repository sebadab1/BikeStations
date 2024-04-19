//
//  BikeStationStatusRepository.swift
//  BikeStations
//
//  Created by Sebastian Dąbrowski on 18.04.2024.
//

import Foundation
import Combine

protocol BikeStationStatusRepository {
    func getStatus() -> AnyPublisher<[BikeStationStatus], Error>
}
