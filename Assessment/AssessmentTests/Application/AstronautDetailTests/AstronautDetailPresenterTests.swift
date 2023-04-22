//
//  AstronautDetailPresenterTests.swift
//  AssessmentTests
//
//  Created by Prabhu on 21/04/23.
//

@testable import Assessment
import XCTest

final class AstronautDetailPresenterTests: XCTestCase {

    // MARK: Properties
    var astronautsPresenter: AstronautDetailPresenter!
    var mockAstronautDetailView: MockAstronautDetailView!

    // MARK: Setup
    override func setUp() {
        mockAstronautDetailView = MockAstronautDetailView()
        let selectedAstronaut = TestUtils.loadMockFromJSON().first
        astronautsPresenter = AstronautDetailPresenter(astronaut: selectedAstronaut)
        astronautsPresenter.attachView(astronautDetailView: mockAstronautDetailView)
    }

    // MARK: Test methods
    func testForDisplayingSelectedAstronautDetails() {
        astronautsPresenter.loadAstronautProfile()
    }
}
