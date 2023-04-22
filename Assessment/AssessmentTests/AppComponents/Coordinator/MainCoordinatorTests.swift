//
//  MainCoordinatorTests.swift
//  AssessmentTests
//
//  Created by Prabhu on 22/04/23.
//

@testable import Assessment
import XCTest

final class MainCoordinatorTests: XCTestCase {

    // MARK: Properties
    var coordinator: MainCoordinator!
    var navController: UINavigationController!

    // MARK: Setup
    override func setUp() {
        navController = UINavigationController()
        coordinator = MainCoordinator(factory: AppFactory(), navigationController: navController)
    }

    func testForAstronautListNavigation() {
        coordinator?.start()
        XCTAssertFalse(navController.viewControllers.isEmpty)
    }

    func testForAstronautDetailsNavigation() {
        if let astronaut = TestUtils.loadMockFromJSON().first {
            coordinator?.showAstronautDetails(for: astronaut)
            XCTAssertFalse(navController.viewControllers.isEmpty)
        }
    }
}
