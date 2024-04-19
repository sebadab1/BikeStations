//
//  GetUserLocationUseCase.swift
//  BikeStations
//
//  Created by Sebastian Dąbrowski on 18.04.2024.
//

import Foundation
import Combine
import CoreLocation

protocol GetUserLocationUseCase {
    func callAsFunction() -> AnyPublisher<CLLocation?, Never>
}

class GetUserLocationUseCaseImpl: NSObject, GetUserLocationUseCase {
    private let locationManager = CLLocationManager()
    private var currentLocationSubject = CurrentValueSubject<CLLocation?, Never>(nil)

    override init() {
        super.init()
        locationManager.delegate = self
    }

    func callAsFunction() -> AnyPublisher<CLLocation?, Never> {
        if locationManager.authorizationStatus == .authorizedWhenInUse || locationManager.authorizationStatus == .authorizedAlways {
            locationManager.requestLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }

        return currentLocationSubject.eraseToAnyPublisher()
    }
}

extension GetUserLocationUseCaseImpl: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocationSubject.send(locations.last)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("\(#function) \(error)")
    }
}
