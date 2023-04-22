//
//  MainCoordinator.swift
//  Assessment
//
//  Created by Prabhu on 20/04/23.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
    func showAstronautDetails(for astronaut: Astronaut)
}

// MARK: Manage navigation flows via coordinator
class MainCoordinator: Coordinator {

    // MARK: Properties
    private let factory: Factory
    var navigationController: UINavigationController

    // MARK: Lifecycle methods
    init(factory: Factory, navigationController: UINavigationController) {
        self.factory = factory
        self.navigationController = navigationController
        buildUI()
    }

    private func buildUI() {

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.get(.appYellow)]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.get(.appYellow)]
        navBarAppearance.backgroundColor = UIColor.get(.appBackground)

        navigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController.navigationBar.standardAppearance = navBarAppearance
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.tintColor = UIColor.get(.appYellow)

    }

}

// MARK: Instance methods
extension MainCoordinator {

    func start() {
        navigationController.pushViewController(factory.createAstronautListVC(self), animated: true)
    }

    func showAstronautDetails(for astronaut: Astronaut) {
        navigationController.pushViewController(factory.createAstronautDetailsVC(for: astronaut),
                                                animated: true)
    }

}
