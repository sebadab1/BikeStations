//
//  BikeStationDetail.swift
//  BikeStations
//
//  Created by Sebastian Dąbrowski on 18.04.2024.
//

import SwiftUI
import MapKit

struct BikeStationDetail: View {
    @StateObject var viewModel: BikeStationDetailViewModel

    init(bikeStation: BikeStation) {
        _viewModel = .init(wrappedValue: BikeStationDetailViewModel(bikeStation: bikeStation))
    }

    var body: some View {
        VStack(spacing: 0) {
            Map(initialPosition: MapCameraPosition.region(
                MKCoordinateRegion(
                    center: .init(latitude: viewModel.latitude, longitude: viewModel.longitude),
                    span: .init(latitudeDelta: 0.02, longitudeDelta: 0.02)
                )
            )) {
                UserAnnotation()

                Annotation("", coordinate: .init(latitude: viewModel.latitude, longitude: viewModel.longitude)) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 360)
                            .fill(Color.white)

                        HStack(spacing: 4) {
                            Text("\(viewModel.availableBikes)")
                                .font(.custom("Manrope", size: 18))
                                .fontWeight(.heavy)

                            Image("Bike")
                                .resizable()
                                .frame(width: 16, height: 16)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                    }
                }
            }

            BikeStationListRow(
                name: viewModel.name,
                address: viewModel.address,
                distance: viewModel.distance,
                availableBikes: viewModel.availableBikes,
                availablePlaces: viewModel.availablePlaces,
                padding: 16
            )
        }
        .onAppear {
            viewModel.onAppearEvent()
        }
    }
}

#Preview {
    let bikeStation = BikeStation(
        name: "GDA123",
        address: "Kępna",
        longitude: 20.12,
        latitude: 51.1,
        status: nil
    )

    return BikeStationDetail(bikeStation: bikeStation)
}
