//
//  Endpoint.swift
//  BikeStations
//
//  Created by Sebastian Dąbrowski on 17.04.2024.
//

import Foundation

enum Endpoint {
    case information
    case status

    var path: String {
        switch self {
        case .information:
            "https://gbfs.urbansharing.com/rowermevo.pl/station_information.json"
        case .status:
            "https://gbfs.urbansharing.com/rowermevo.pl/station_status.json"
        }
    }

    var method: HTTPMethod {
        return .get
    }
}
