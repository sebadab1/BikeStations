//
//  BikeStationListItem.swift
//  BikeStations
//
//  Created by Sebastian Dąbrowski on 18.04.2024.
//

import SwiftUI

struct BikeStationListItem: View {
    let itemType: ItemType
    let availableBikes: Int
    let availablePlaces: Int

    var body: some View {
        VStack(spacing: 0) {
            Image(itemType == .bikes ? "Bike" : "Lock")

            Spacer()
                .frame(height: 8)

            Text(itemType == .bikes ? "\(availableBikes)" : "\(availablePlaces)")
                .font(.custom("Manrope", size: 44))
                .foregroundStyle(itemType == .bikes ? (availableBikes != 0 ? Color("BikeCountColor") : Color.red) : Color.black)
                .fontWeight(.heavy)

            Text(itemType == .bikes ? "Bikes available" : "Places available")
                .font(.custom("Manrope", size: 12))
                .fontWeight(.semibold)
        }
        .padding(.bottom, 20)
    }
}

#Preview {
    HStack(spacing: 100) {
        BikeStationListItem(
            itemType: .bikes,
            availableBikes: 20,
            availablePlaces: 5
        )

        BikeStationListItem(
            itemType: .places,
            availableBikes: 20,
            availablePlaces: 5
        )
    }
}
