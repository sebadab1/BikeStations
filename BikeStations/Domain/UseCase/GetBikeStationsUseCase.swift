//
//  GetBikeStationsUseCase.swift
//  BikeStations
//
//  Created by Sebastian Dąbrowski on 17.04.2024.
//

import Foundation
import Combine

protocol GetBikeStationsUseCase {
    func callAsFunction() -> AnyPublisher<[BikeStation], Error>
}

class GetBikeStationsUseCaseImpl: GetBikeStationsUseCase {
    @Injected var bikeStationRepository: BikeStationInfoRepository
    @Injected var bikeStationStatusRepository: BikeStationStatusRepository
    @Injected var getUserLocationUseCase: GetUserLocationUseCase

    func callAsFunction() -> AnyPublisher<[BikeStation], Error> {
        Publishers.CombineLatest3(
            bikeStationRepository.getAll(),
            bikeStationStatusRepository.getStatus(),
            getUserLocationUseCase().setFailureType(to: Error.self)
        )
        .receive(on: DispatchQueue.global(qos: .userInitiated))
        .map { infoList, statusList, location in
            return infoList.map { info in
                let status = statusList.first { $0.identifier == info.identifier }
                return BikeStation(
                    name: info.name,
                    address: info.address,
                    longitude: info.longitude,
                    latitude: info.latitude,
                    status: status
                )
            }
        }
        .eraseToAnyPublisher()
    }
}
