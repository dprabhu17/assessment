//
//  AppDelegate.swift
//  Assessment
//
//  Created by Prabhu on 19/04/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Properties
    var window: UIWindow?

    // MARK: Application Lifecycle methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let repository = AstronautsRepository(client: HTTPServices())
        let astronautsPresenter = AstronautListPresenter(astronautRepository: repository)
        let astronautsDataSource = AstronautDataSource(presenter: astronautsPresenter)
        let astronautListVC = AstronautListViewController(astronautsPresenter: astronautsPresenter,
                                                          astronautsDataSource: astronautsDataSource)
        let navigationController = UINavigationController(rootViewController: astronautListVC)
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.get(.appYellow)]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.get(.appYellow)]
        navBarAppearance.backgroundColor = UIColor.get(.appBackground)

        navigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController.navigationBar.standardAppearance = navBarAppearance
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.tintColor = UIColor.get(.appYellow)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
