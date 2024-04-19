//
//  BikeStationListDescription.swift
//  BikeStations
//
//  Created by Sebastian Dąbrowski on 18.04.2024.
//

import SwiftUI

struct BikeStationListDescription: View {
    let name: String
    let address: String
    let distance: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(name)
                .padding(.top, 8)
                .font(.custom("Manrope", size: 24))
                .fontWeight(.heavy)

            HStack {
                Text(distance)
                    .fontWeight(.heavy)

                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 5, height: 5)
                    .fontWeight(.bold)

                Text(address)
                    .fontWeight(.semibold)
            }
        }
        .font(.custom("Manrope", size: 12))
    }
}

#Preview {
    BikeStationListDescription(
        name: "GDA123",
        address: "Kępna",
        distance: "500m"
    )
}
