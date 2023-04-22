//
//  AstronautDetailViewControllerTests.swift
//  AssessmentTests
//
//  Created by Prabhu on 22/04/23.
//

@testable import Assessment
import XCTest

final class AstronautDetailViewControllerTests: XCTestCase {

    // MARK: Properties
    var astronaut: Astronaut?
    var mockDetailView: MockAstronautDetailView!
    var astronautsDetailsPresenter: AstronautDetailPresenter!
    var astronautDetailViewController: AstronautDetailViewController!
    var expectation: XCTestExpectation!

    // MARK: Setup
    override func setUp() {
        astronaut = TestUtils.loadMockFromJSON().first
        mockDetailView = MockAstronautDetailView()
        astronautsDetailsPresenter = AstronautDetailPresenter(astronaut: astronaut)
        astronautDetailViewController = AstronautDetailViewController(astronautsDetailPresenter: astronautsDetailsPresenter)
        astronautsDetailsPresenter.attachView(astronautDetailView: mockDetailView)
    }

    // MARK: Test methods
    func testInitWithCoder() {
        let astronautDetailVC = AstronautDetailViewController(coder: NSCoder())
        XCTAssertNil(astronautDetailVC)
    }

    func testAstronautDetailsForValidData() {
        givenAstronautDetailViewControllerLoaded()
        whenLoadAstronautProfileFromPresenter()
        thenAstronautDetailsDisplayed()
    }

    func testAstronautDetailsForInValidData() {
        givenAstronautDetailViewControllerLoadedWithoutAstronaut()
        whenFailedToLoadAstronautProfileFromPresenter()
        thenAstronautDetailsWillBeHidden()
    }

}

extension AstronautDetailViewControllerTests {

    func givenAstronautDetailViewControllerLoaded() {
        astronautsDetailsPresenter.attachView(astronautDetailView: mockDetailView)
    }

    func whenLoadAstronautProfileFromPresenter() {
        checkForViewDidLoad()
        XCTAssertTrue(mockDetailView.astronautDetailsDisplyed)
    }

    func givenAstronautDetailViewControllerLoadedWithoutAstronaut() {
        astronautsDetailsPresenter = AstronautDetailPresenter(astronaut: nil)
    }

    func checkForViewDidLoad() {
        astronautDetailViewController.loadViewIfNeeded()
        astronautDetailViewController.viewDidLoad()
        astronautDetailViewController.viewDidLayoutSubviews()
    }

    func whenFailedToLoadAstronautProfileFromPresenter() {
        checkForViewDidLoad()
    }

    func thenAstronautDetailsDisplayed() {
        if let astronaut = astronaut {
            let placeholderImage = astronautDetailViewController.imgProfile.image
            astronautDetailViewController.showDetail(for: astronaut)
            XCTAssertEqual(astronautDetailViewController.lblFirstName.text ?? "", astronaut.name)
            XCTAssertEqual(astronautDetailViewController.lblBiography.text ?? "", astronaut.biography)
            XCTAssertEqual(astronautDetailViewController.lblNationality.text ?? "", astronaut.nationality)
            XCTAssertEqual(astronautDetailViewController.lblDateOfBirth.text ?? "", astronaut.dateOfBirth)
            // loading profile image
            expectation = expectation(description: "Wait 5 seconds to download an profile image")
            astronautDetailViewController.imgProfile.setImage(url: astronaut.profileImageThumbnail)
            let result = XCTWaiter.wait(for: [expectation], timeout: 5.0)
            if result == XCTWaiter.Result.timedOut {
                let downloadedImage = astronautDetailViewController.imgProfile.image
                XCTAssertNotEqual(placeholderImage, downloadedImage)
            }
        }
    }

    func thenAstronautDetailsWillBeHidden() {
        XCTAssertTrue(astronautDetailViewController.vwName.isHidden)
        XCTAssertTrue(astronautDetailViewController.vwBiography.isHidden)
        XCTAssertTrue(astronautDetailViewController.vwNationality.isHidden)
        XCTAssertTrue(astronautDetailViewController.vwDateOfBirth.isHidden)
        astronautDetailViewController.viewWillDisappear(true)
    }
}
