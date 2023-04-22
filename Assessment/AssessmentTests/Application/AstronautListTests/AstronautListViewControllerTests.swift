//
//  AstronautListViewControllerTests.swift
//  AssessmentTests
//
//  Created by Prabhu on 21/04/23.
//

@testable import Assessment
import XCTest
import RxSwift

final class AstronautListViewControllerTests: XCTestCase {

    // MARK: Properties
    var mockCoordinator: MainCoordinatorMock!
    var mockRepository: AstronautRepositoryMock!
    var astronautsListPresenter: AstronautListPresenter!
    var astronautsDataSource: AstronautDataSource!
    var astronautListVC: AstronautListViewController!
    var expectation: XCTestExpectation!

    // MARK: Setup
    override func setUp() {
        mockCoordinator = MainCoordinatorMock()
        mockRepository = AstronautRepositoryMock()
        astronautsListPresenter = AstronautListPresenter(astronautRepository: mockRepository)
        astronautsDataSource = AstronautDataSource(presenter: astronautsListPresenter)
        astronautListVC = AstronautListViewController(astronautsPresenter: astronautsListPresenter,
                                                      astronautsDataSource: astronautsDataSource,
                                                      coordinator: mockCoordinator)
        astronautsListPresenter.attachView(astronautListView: self)
    }

    // MARK: Tests
    func testInitWithCoder() {
        let astronautListVC = AstronautListViewController(coder: NSCoder())
        XCTAssertNil(astronautListVC)
    }

    func testForDisplayingAstronautsList() {
        executeTestsTillLoadingAstronautsListSuccessfully()
    }

    func testFilterAstronautsBasedOnName() {
        givenAstronautsListBeforeFilterAction()
        whenPerformingFilterByName()
        thenReceivedAstronautListDisplayedInTableView()
    }

    func testForHandlingErrorWhenDisplayingAstronautsList() {
        givenViewControllerLoadedForFailedResult()
        whenRetrievingAllAstronauts()
        thenDisplayLoadingStatus()
        thenHideLoadingStatus()
        thenDisplayReceivedErrorMessage()
    }

    func testTableViewCellsForLazyLoading() {
        givenAstronautsListBeforeFilterAction()
        whenAstronautListDisplayedInTableView()
        thenTestTableViewCellForLazyLoading()
    }

    func testForDisplayingAstronautDetails() {
        givenAstronautsListBeforeFilterAction()
        whenUserSelectAnAstronautFromTableView()
        thenDisplayLoadingStatus()
        whenRetrievingSelectedAstronaut()
        thenHideLoadingStatus()
        thenAstronautDetailsScreenLoaded()
    }

}
extension AstronautListViewControllerTests: AstronautListView {

    func filterRecords() {
        expectation.fulfill()
        XCTAssertNotNil(astronautListVC.reloadData())
    }

    func showLoadingStatus() {
        expectation.fulfill()
        XCTAssertNotNil(astronautListVC.showLoadingStatus())
    }

    func hideLoadingStatus() {
        expectation.fulfill()
        XCTAssertNotNil(astronautListVC.hideLoadingStatus())
    }

    func reloadData() {
        expectation.fulfill()
        XCTAssertNotNil(astronautListVC.reloadData())
    }

    func showErrorWith(message: String?) {
        expectation.fulfill()
        XCTAssertNotNil(astronautListVC.showErrorWith(message: message))
    }

    func showDetail(for astronaut: Assessment.Astronaut) {
        expectation.fulfill()
        XCTAssertNotNil(astronautListVC.showDetail(for: astronaut))
    }
}
extension AstronautListViewControllerTests {

    func givenAstronautsListBeforeFilterAction() {
        executeTestsTillLoadingAstronautsListSuccessfully()
    }

    func executeTestsTillLoadingAstronautsListSuccessfully() {
        givenViewControllerLoaded()
        whenRetrievingAllAstronauts()
        thenDisplayLoadingStatus()
        thenAstronautListReceived()
        thenHideLoadingStatus()
        thenReceivedAstronautListDisplayedInTableView()
    }

    func givenViewControllerLoaded() {
        mockRepository.astronautsResultMock = AstronautRepositoryMock.prepareAstronautsMock()
        XCTAssertNotNil(mockRepository.astronautsResultMock)
    }

    func givenViewControllerLoadedForFailedResult() {
        mockRepository.astronautsResultMock = AstronautRepositoryMock.prepareErrorMockForAstronautsMock(error: .decodingError)
        XCTAssertNotNil(mockRepository.astronautsResultMock)
    }

    func whenRetrievingAllAstronauts() {
        expectation = XCTestExpectation(description: "Load astronaut list in viewDidLoad")
        astronautListVC.beginAppearanceTransition(true, animated: true)
        astronautListVC.viewDidLoad()
    }

    func thenDisplayLoadingStatus() {
        expectation = XCTestExpectation(description: "Display loading status")
        XCTAssertNotNil(astronautListVC.showLoadingStatus())
    }

    func thenAstronautListReceived() {
        XCTAssertFalse(astronautListVC.astronautsPresenter.getAstronauts().isEmpty)
    }

    func thenHideLoadingStatus() {
        expectation = XCTestExpectation(description: "Hide loading status")
        XCTAssertNotNil(astronautListVC.hideLoadingStatus())
    }

    func thenReceivedAstronautListDisplayedInTableView() {
        XCTAssertEqual(astronautListVC.tblAstronaut.numberOfRows(inSection: 0),
                       astronautsListPresenter.getAstronauts().count)
    }

    func whenAstronautListDisplayedInTableView() {
        XCTAssertEqual(astronautListVC.tblAstronaut.numberOfRows(inSection: 0),
                       astronautsListPresenter.getAstronauts().count)
    }

    func thenTestTableViewCellForLazyLoading() {
        CustomDownloadManager.shared.cancelAll()
        let indexPath = IndexPath(item: 0, section: 0)
        if let currentCell = astronautsDataSource.tableView(astronautListVC.tblAstronaut,
                                                            cellForRowAt: indexPath) as? AstronautCell {
            currentCell.model = astronautsListPresenter.getAstronaut(by: indexPath)
            astronautsDataSource.tableView(astronautListVC.tblAstronaut,
                                           didEndDisplaying: currentCell,
                                           forRowAt: indexPath)
            expectation = expectation(description: "Wait 5 seconds to download an image")
            astronautsDataSource.loadImageOnlyForVisibleCell(tableView: astronautListVC.tblAstronaut, cell: currentCell, for: indexPath)
            let result = XCTWaiter.wait(for: [expectation], timeout: 5.0)
            if result == XCTWaiter.Result.timedOut {
                XCTAssertNotNil(currentCell.image)
                XCTAssertNotNil(CustomDownloadManager.shared.imageCache)
            }
        }
    }

    func whenPerformingFilterByName() {
        expectation = XCTestExpectation(description: "Filter astronauts list by name")
        XCTAssertNotNil(astronautListVC.filterRecords())
    }

    func thenDisplayReceivedErrorMessage() {
        XCTAssertTrue(astronautListVC.astronautsPresenter.getAstronauts().isEmpty)
    }

    func thenDisplayAstronautDetailScreen() {
        XCTAssertTrue(mockCoordinator.astronautDetailsShown)
    }

    func whenUserSelectAnAstronautFromTableView() {
        mockRepository.astronautByIdResultMock = AstronautRepositoryMock.prepareMockForAstronautById()
        astronautListVC.astronautsDataSource.tableView(astronautListVC.tblAstronaut,
                                                       didSelectRowAt: IndexPath(row: 0, section: 0))
    }

    func whenRetrievingSelectedAstronaut() {
        XCTAssertFalse(astronautsListPresenter.getAstronauts().isEmpty)
        let astronaut = astronautsListPresenter.getAstronaut(by: IndexPath(item: 0, section: 0))
        astronautsListPresenter.onSelect(astronaut: astronaut)
        XCTAssertNotNil(astronaut)
    }

    func thenAstronautDetailsScreenLoaded() {
        XCTAssertTrue(mockCoordinator.astronautDetailsShown)
    }

}
