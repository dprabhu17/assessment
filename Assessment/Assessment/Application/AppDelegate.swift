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
    var coordinator: MainCoordinator?

    // MARK: Application Lifecycle methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Launch initial view controller via Coordinator
        let navController = UINavigationController()
        coordinator = MainCoordinator(factory: AppFactory(), navigationController: navController)
        coordinator?.start()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }
}
