//
//  MainCoordinatorMock.swift
//  AssessmentTests
//
//  Created by Prabhu on 21/04/23.
//

@testable import Assessment
import Foundation
import UIKit
class MainCoordinatorMock: Coordinator {

    var navigationController: UINavigationController = UINavigationController()
    var coordinatorStarted = false
    var astronautDetailsShown = false

    func start() {
        coordinatorStarted = true
    }

    func showAstronautDetails(for astronaut: Astronaut) {
        astronautDetailsShown = true
    }
}
