//
//  AstronautListPresenter.swift
//  Assessment
//
//  Created by Prabhu on 19/04/23.
//

import Foundation
import RxSwift

class AstronautListPresenter {

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

    func showAstronautsBasedOnFilter() {
        filteredByName = !filteredByName
        astronauts = filteredByName ? receivedAstronauts.sorted { $0.name ?? "" < $1.name ?? ""} : receivedAstronauts
        astronautListView?.reloadData()
    }

    func loadAstronauts() {
        astronautListView?.showLoadingStatus()
        astronautRepository.getAstronauts()
            .subscribe { [weak self] austronauts in
                self?.showAstronauts(astronauts: austronauts)
            } onFailure: { [weak self] error in
                self?.astronautListView?.showErrorWith(message: error.errorDescription)
            } onDisposed: { [weak self] in
                self?.astronautListView?.hideLoadingStatus()
            }.disposed(by: disposeBag)
    }

    func showAstronauts(astronauts: [Astronaut]) {
        receivedAstronauts = astronauts
        showAstronautsBasedOnFilter()
    }

    public func onSelect(austronaut selectedAstronaut: Astronaut) {
        guard let astronautId = selectedAstronaut.astronautId else { return }
        astronautListView?.showLoadingStatus()
        astronautRepository.getAstronaut(by: astronautId)
            .subscribe { [weak self] austronaut in
                self?.astronautListView?.showDetail(for: austronaut)
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
