//
//  BikeStationListRow.swift
//  BikeStations
//
//  Created by Sebastian Dąbrowski on 17.04.2024.
//

import SwiftUI

enum ItemType {
    case bikes
    case places
}

struct BikeStationListRow: View {
    let name: String
    let address: String
    let distance: String
    let availableBikes: Int
    let availablePlaces: Int
    let padding: CGFloat

    var body: some View {
        VStack(alignment: .leading) {
            BikeStationListDescription(
                name: name,
                address: address,
                distance: distance
            )
            .padding(.leading, padding)

            Spacer()
                .frame(height: 20)

            HStack(spacing: 40) {
                BikeStationListItem(
                    itemType: .bikes,
                    availableBikes: availableBikes,
                    availablePlaces: availablePlaces
                )

                BikeStationListItem(
                    itemType: .places,
                    availableBikes: availableBikes,
                    availablePlaces: availablePlaces
                )
            }
            .frame(maxWidth: .infinity)
        }
        .background {
            Color.white
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 8)
        }
    }
}

#Preview {
    VStack(spacing: 8) {
        BikeStationListRow(
            name: "GDA123",
            address: "Kępna",
            distance: "800m",
            availableBikes: 0,
            availablePlaces: 0,
            padding: 16
        )

        BikeStationListRow(
            name: "GDA123",
            address: "Kępna",
            distance: "800m",
            availableBikes: 1,
            availablePlaces: 10,
            padding: 16
        )
    }
}
