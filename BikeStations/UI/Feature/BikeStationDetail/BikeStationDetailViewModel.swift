//
//  BikeStationDetailViewModel.swift
//  BikeStations
//
//  Created by Sebastian Dąbrowski on 18.04.2024.
//

import Foundation
import Combine
import CoreLocation

class BikeStationDetailViewModel: ObservableObject {
    @Injected var getUserLocationUseCase: GetUserLocationUseCase
    @Published var distance: String = ""

    var name: String {
        bikeStation.name
    }

    var address: String {
        bikeStation.address
    }

    var availableBikes: Int {
        guard let status = bikeStation.status else {
            return 0
        }

        return status.availableBikes
    }

    var availablePlaces: Int {
        guard let status = bikeStation.status else {
            return 0
        }

        return status.availablePlaces
    }

    var longitude: Double {
        bikeStation.longitude
    }

    var latitude: Double {
        bikeStation.latitude
    }

    private let bikeStation: BikeStation
    private var cancellables = Set<AnyCancellable>()

    init(bikeStation: BikeStation) {
        self.bikeStation = bikeStation
    }

    func onAppearEvent() {
        getUserLocationUseCase()
            .compactMap { $0 }
            .sink { [weak self] location in
                guard let self else {
                    return
                }

                let bikeStationLocation = CLLocation(latitude: bikeStation.latitude, longitude: bikeStation.longitude)
                let meters = location.distance(from: bikeStationLocation)
                let measurment = Measurement(value: meters, unit: UnitLength.meters)
                let formatter = MeasurementFormatter()
                formatter.numberFormatter.maximumFractionDigits = 2
                formatter.unitOptions = .naturalScale

                distance = formatter.string(from: measurment)
            }
            .store(in: &cancellables)
    }
}
