//
//  BikeStationDetailViewController.swift
//  BikeStations
//
//  Created by Sebastian Dąbrowski on 18.04.2024.
//

import Foundation
import UIKit
import SwiftUI

final class BikeStationDetailViewController: UIViewController {
    lazy var hostingController = UIHostingController(
        rootView:
            BikeStationDetail(bikeStation: bikeStation)
    )

    private let bikeStation: BikeStation

    init(bikeStation: BikeStation) {
        self.bikeStation = bikeStation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        view.addSubview(hostingController.view)
    }

    private func setupConstraints() {
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
