//
//  BikeStationInfoRepository.swift
//  BikeStations
//
//  Created by Sebastian Dąbrowski on 17.04.2024.
//

import Foundation
import Combine

protocol BikeStationInfoRepository {
    func getAll() -> AnyPublisher<[BikeStationInfo], Error>
}
