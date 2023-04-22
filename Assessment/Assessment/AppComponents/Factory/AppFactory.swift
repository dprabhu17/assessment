//
//  DependencyFactory.swift
//  Assessment
//
//  Created by Prabhu on 20/04/23.
//

import Foundation

protocol Factory {
    func createAstronautListVC(_ coordinator: Coordinator) -> AstronautListViewController
    func createAstronautDetailsVC(for astronautId: Astronaut) -> AstronautDetailViewController
}

// MARK: Create objects without disclosing the details via this AppFactory
class AppFactory: Factory {

    // MARK: Properties
    private let astronautRepository = AstronautsRepository(client: HTTPServices())

    // creates Astronaut List
    func createAstronautListVC(_ coordinator: Coordinator) -> AstronautListViewController {

        let astronautsPresenter = AstronautListPresenter(astronautRepository: astronautRepository)
        let astronautsDataSource = AstronautDataSource(presenter: astronautsPresenter)
        let astronautListVC = AstronautListViewController(astronautsPresenter: astronautsPresenter,
                                                          astronautsDataSource: astronautsDataSource,
                                                          coordinator: coordinator)
        astronautsPresenter.attachView(astronautListView: astronautListVC)
        return astronautListVC

    }

    // creates Astronaut detail
    func createAstronautDetailsVC(for astronaut: Astronaut) -> AstronautDetailViewController {
        let astronautsPresenter = AstronautDetailPresenter(astronaut: astronaut)
        let astronautDetailViewController = AstronautDetailViewController(astronautsDetailPresenter: astronautsPresenter)
        astronautsPresenter.attachView(astronautDetailView: astronautDetailViewController)
        return astronautDetailViewController
    }

}
