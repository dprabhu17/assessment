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

        let stronautListViewController = AstronautListViewController(nibName: "AstronautListViewController",
                                                                      bundle: nil)
        let navController = UINavigationController(rootViewController: stronautListViewController)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }
}
