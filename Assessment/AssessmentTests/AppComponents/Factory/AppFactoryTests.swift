//
//  AppFactoryTests.swift
//  AssessmentTests
//
//  Created by Prabhu on 22/04/23.
//

@testable import Assessment
import XCTest

final class AppFactoryTests: XCTestCase {

    // MARK: Properties
    var appFactory: AppFactory!
    var coordinator: MainCoordinator!
    var navController: UINavigationController!

    // MARK: Setup
    override func setUp() {
        navController = UINavigationController()
        coordinator = MainCoordinator(factory: AppFactory(), navigationController: navController)
        appFactory = AppFactory()
    }

    func testCreateAstronautListVC() {
        XCTAssertNotNil(appFactory.createAstronautListVC(coordinator))
    }

    func testCreateAstronautDetailsVC() {
        if let astronaut = TestUtils.loadMockFromJSON().first {
            XCTAssertNotNil(appFactory.createAstronautDetailsVC(for: astronaut))
        }
    }
}
