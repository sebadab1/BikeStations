//
//  BikeStationListViewModel.swift
//  BikeStations
//
//  Created by Sebastian Dąbrowski on 17.04.2024.
//

import Foundation
import Combine
import CoreLocation

protocol BikeStationListViewModelDelegate: AnyObject {
    func viewModel(_ viewModel: BikeStationListViewModel, didFetchBikeStations stations: [BikeStation])
    func viewModelDidFetchNewLocation(_ viewModel: BikeStationListViewModel)
}

final class BikeStationListViewModel {
    @Injected var getBikeStationsUseCase: GetBikeStationsUseCase
    @Injected var getUserLocationUseCase: GetUserLocationUseCase

    weak var delegate: BikeStationListViewModelDelegate?

    private var lastLocation: CLLocation?
    private var cancellables: Set<AnyCancellable> = []

    func getBikeStations() {
        getBikeStationsUseCase()
            .materialize()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                guard let self else {
                    return
                }

                switch result {
                case .success(let stations):
                    delegate?.viewModel(self, didFetchBikeStations: stations)
                case .failure(let error):
                    print("\(#function) \(error)")
                }
            }
            .store(in: &cancellables)

        getUserLocationUseCase()
            .sink { [weak self] location in
                guard let self else {
                    return
                }

                lastLocation = location
                delegate?.viewModelDidFetchNewLocation(self)
            }
            .store(in: &cancellables)
    }

    func getDistance(for bikeStation: BikeStation) -> String {
        guard let lastLocation else {
            return ""
        }

        let bikeStationLocation = CLLocation(latitude: bikeStation.latitude, longitude: bikeStation.longitude)
        let meters = lastLocation.distance(from: bikeStationLocation)
        let measurment = Measurement(value: meters, unit: UnitLength.meters)
        
        let formatter = MeasurementFormatter()
        formatter.numberFormatter.maximumFractionDigits = 2
        formatter.unitOptions = .naturalScale

        return formatter.string(from: measurment)
    }
}
