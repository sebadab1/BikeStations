//
//  BikeStationListViewController.swift
//  BikeStations
//
//  Created by Sebastian Dąbrowski on 17.04.2024.
//

import Foundation
import UIKit
import SwiftUI

enum Section: Int {
    case main
}

final class BikeStationListViewController: UIViewController {
    @Injected var viewModel: BikeStationListViewModel

    typealias DataSource = UICollectionViewDiffableDataSource<Section, BikeStation>
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, BikeStation>

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    private lazy var dataSource = createDataSource()
    private let cellIdentifier = "cellID"

    init() {
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        addSubviews()
        setupSubviews()
        setupConstraints()

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        viewModel.getBikeStations()
    }

    func addSubviews() {
        view.addSubview(collectionView)
    }

    func setupSubviews() {
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor(named: "BackgroundColor")
    }

    func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionNumber, environment -> NSCollectionLayoutSection? in
            var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
            configuration.backgroundColor = UIColor(named: "BackgroundColor")
            configuration.showsSeparators = false
            
            let section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: environment)
            section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: -8, bottom: 0, trailing: -8)
            section.interGroupSpacing = -8

            return section
        }
    }

    private func createDataSource() -> DataSource {
        return DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, item in
            guard let self else {
                return UICollectionViewCell()
            }

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)

            cell.contentConfiguration = UIHostingConfiguration {
                BikeStationListRow(
                    name: item.name,
                    address: item.address,
                    distance: self.viewModel.getDistance(for: item),
                    availableBikes: item.status?.availableBikes ?? 0,
                    availablePlaces: item.status?.availablePlaces ?? 0,
                    padding: 16
                )
            }
            
            return cell
        }
    }
}

extension BikeStationListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else {
            return
        }

        let viewController = BikeStationDetailViewController(bikeStation: item)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension BikeStationListViewController: BikeStationListViewModelDelegate {
    func viewModelDidFetchNewLocation(_ viewModel: BikeStationListViewModel) {
        var snapshot = dataSource.snapshot()

        guard snapshot.sectionIdentifiers.contains(where: { $0 == .main }) else {
            return
        }

        snapshot.reloadSections([.main])
        dataSource.apply(snapshot)
    }
    
    func viewModel(_ viewModel: BikeStationListViewModel, didFetchBikeStations stations: [BikeStation]) {
        var snapshot = DataSourceSnapshot()
        snapshot.appendSections([Section.main])
        snapshot.appendItems(stations, toSection: Section.main)
        dataSource.apply(snapshot)
    }
}
