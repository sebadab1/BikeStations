//
//  AppDelegate.swift
//  BikeStations
//
//  Created by Sebastian Dąbrowski on 17.04.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let appearance = UINavigationBarAppearance()
        let barButtonItemAppearance = UIBarButtonItemAppearance(style: .plain)
        barButtonItemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]

        appearance.backgroundColor = UIColor(named: "NavigationBarColor")
        appearance.setBackIndicatorImage(UIImage(named: "Arrow"), transitionMaskImage: UIImage(named: "Arrow"))
        appearance.backButtonAppearance = barButtonItemAppearance

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance

        register()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    private func register() {
        DependencyContainer.shared.register(APIClient.self, APIClient.init)
        DependencyContainer.shared.register(BikeStationMapper.self, BikeStationMapperImpl.init)
        DependencyContainer.shared.register(BikeStationStatusMapper.self, BikeStationStatusMapperImpl.init)
        DependencyContainer.shared.register(BikeStationInfoRepository.self, BikeStationInfoRepositoryImpl.init)
        DependencyContainer.shared.register(BikeStationStatusRepository.self, BikeStationStatusRepositoryImpl.init)
        DependencyContainer.shared.register(BikeStationListViewModel.self, BikeStationListViewModel.init)
        DependencyContainer.shared.register(GetUserLocationUseCase.self, GetUserLocationUseCaseImpl.init)
        DependencyContainer.shared.register(GetBikeStationsUseCase.self, GetBikeStationsUseCaseImpl.init)
    }
}

