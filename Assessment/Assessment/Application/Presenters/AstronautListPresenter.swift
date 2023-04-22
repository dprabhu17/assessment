//
//  AstronautListPresenter.swift
//  Assessment
//
//  Created by Prabhu on 19/04/23.
//

import Foundation
import RxSwift

public class AstronautListPresenter {

    // MARK: Properties
    private weak var astronautListView: AstronautListView?
    private let astronautRepository: Repository
    private var receivedAstronauts = [Astronaut]()
    private var disposeBag = DisposeBag()
    private var astronauts = [Astronaut]()
    var filteredByName: Bool = true

    // MARK: Lifecycle methods
    public init(astronautRepository: Repository) {
        self.astronautRepository = astronautRepository
    }

    // Inject via method
    func attachView(astronautListView: AstronautListView) {
        self.astronautListView = astronautListView
    }

}

// MARK: Instance Methods
extension AstronautListPresenter {

    private func showAstronauts(astronauts: [Astronaut]) {
        receivedAstronauts = astronauts
        showAstronautsBasedOnFilter()
    }

    func showAstronautsBasedOnFilter() {
        filteredByName = !filteredByName
        astronauts = filteredByName ? receivedAstronauts.sorted { $0.name < $1.name} : receivedAstronauts
        astronautListView?.reloadData()
    }

    // Load astronauts from api
    func loadAstronauts() {
        astronautListView?.showLoadingStatus()
        astronautRepository.getAstronauts()
            .subscribe { [weak self] astronauts in
                self?.showAstronauts(astronauts: astronauts)
            } onFailure: { [weak self] error in
                self?.astronautListView?.showErrorWith(message: error.errorDescription)
            } onDisposed: { [weak self] in
                self?.astronautListView?.hideLoadingStatus()
            }.disposed(by: disposeBag)
    }

    // Get selected astronaut detail from api
    func onSelect(astronaut selectedAstronaut: Astronaut) {
        let astronautId = selectedAstronaut.astronautId
        astronautListView?.showLoadingStatus()
        astronautRepository.getAstronaut(by: astronautId)
            .subscribe { [weak self] astronaut in
                self?.astronautListView?.showDetail(for: astronaut)
            } onFailure: { [weak self] error in
                self?.astronautListView?.showErrorWith(message: error.errorDescription)
            } onDisposed: { [weak self] in
                self?.astronautListView?.hideLoadingStatus()
            }.disposed(by: disposeBag)
    }

    func getAstronauts() -> [Astronaut] {
        return astronauts
    }

    func getAstronaut(by indexPath: IndexPath) -> Astronaut {
        return astronauts[indexPath.row]
    }
}
