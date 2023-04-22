//
//  AstronautDetailPresenter.swift
//  Assessment
//
//  Created by Prabhu on 20/04/23.
//

import Foundation
import RxSwift

class AstronautDetailPresenter {

    // MARK: Properties
    private weak var astronautDetailView: AstronautDetailView?
    private var astronaut: Astronaut?

    // MARK: Lifecycle methods
    public init(astronaut: Astronaut?) {
        self.astronaut = astronaut
    }

    // Inject via method
    func attachView(astronautDetailView: AstronautDetailView) {
        self.astronautDetailView = astronautDetailView
    }

}

// MARK: Instance methods
extension AstronautDetailPresenter {

    func loadAstronautProfile() {
        guard let astronaut = astronaut else { return }
        astronautDetailView?.showDetail(for: astronaut)
    }

}
