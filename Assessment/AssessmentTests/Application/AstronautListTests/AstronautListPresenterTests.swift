//
//  AstronautListPresenterTests.swift
//  AssessmentTests
//
//  Created by Prabhu on 21/04/23.
//

@testable import Assessment
import XCTest
import RxSwift

final class AstronautListPresenterTests: XCTestCase {

    // MARK: Properties
    var mockRepository: AstronautRepositoryMock!
    var astronautsListPresenter: AstronautListPresenter!
    var astronautsDataSource: AstronautDataSource!
    var mockAstronautListView: MockAstronautListView!
    let errorsList = [NetworkError.domainError, NetworkError.noNetworkFound,
                      NetworkError.decodingError, NetworkError.urlError]

    // MARK: Setup
    override func setUp() {
        mockRepository = AstronautRepositoryMock()
        mockAstronautListView = MockAstronautListView()
        astronautsListPresenter = AstronautListPresenter(astronautRepository: mockRepository)
        astronautsListPresenter.attachView(astronautListView: mockAstronautListView)
    }

    // MARK: Tests
    func testToLoadAstronautList() {
        executeTestsTillLoadingAstronautsListSuccessfully()
    }

    func testToHandleErrorsWhenLoadingAstronautList() {
        // Test list of errors when retrieving astronauts
        for currentError in errorsList {
            mockAstronautListView.reset()
            let result = AstronautRepositoryMock.prepareErrorMockForAstronautsMock(error: currentError)
            givenSetRepositoryAllAstronauts(for: result)
            whenRetrievingAllAstronauts()
            thenDisplayLoadingStatus()
            thenAllAstronautsAPIExecutionCompletedWithoutResults()
            thenHideLoadingStatus()
            thenDisplayErrorMessage(for: currentError)
        }
    }

    func testToLoadSelectedAstronautDetails() {
        // Load all astronauts
        whenAllAstronauntsSuccessfully()

        // Test by selecting a astronaut from loaded items
        whenAllAstronauntsSuccessfully()
        let selectedAstronautResult = AstronautRepositoryMock.prepareMockForAstronautById()
        givenSetRepositoryToLoadSelectedAstronaut(result: selectedAstronautResult)
        thenDisplayLoadingStatus()
        whenUserSelectAnAstronautWhenUserTapAnItem()
        thenHideLoadingStatus()
        thenAstronautDetailsDisplayed()
    }

    func testToHandleErrorsWhenSelectingAnAstronaut() {
        // Load all astronauts
        whenAllAstronauntsSuccessfully()

        // Handle list of errors when selecting an astronaut
        for currentError in errorsList {
            let selectedAstronautResult = AstronautRepositoryMock.prepareErrorMockForAstronautById(error: currentError)
            givenSetRepositoryToLoadSelectedAstronaut(result: selectedAstronautResult)
            thenDisplayLoadingStatus()
            whenUserSelectAnAstronautWhenUserTapAnItem()
            thenHideLoadingStatus()
            thenDisplayErrorMessage(for: currentError)
        }
    }

    func testForFilteredAstronautListBasedOnName() {
        whenAllAstronauntsSuccessfully()
        let firstAstronautNameBeforeSorting = astronautsListPresenter.getAstronauts().first?.name ?? ""
        astronautsListPresenter.showAstronautsBasedOnFilter()
        let firstAstronautNameAfterSorting = astronautsListPresenter.getAstronauts().first?.name ?? ""
        XCTAssertNotEqual(firstAstronautNameBeforeSorting, firstAstronautNameAfterSorting)
    }

}

extension AstronautListPresenterTests {

    func executeTestsTillLoadingAstronautsListSuccessfully() {
        let result = AstronautRepositoryMock.prepareAstronautsMock()
        givenSetRepositoryAllAstronauts(for: result)
        whenRetrievingAllAstronauts()
        thenDisplayLoadingStatus()
        thenAllAstronautsAPIExecutionCompleted()
        thenHideLoadingStatus()
        thenRetrievedAstronautsDisplayedInView()
    }

    func whenAllAstronauntsSuccessfully() {
        executeTestsTillLoadingAstronautsListSuccessfully()
    }

    func givenSetRepositoryAllAstronauts(for result: Single<[Astronaut]>) {
        mockRepository.astronautsResultMock = result
        XCTAssertNotNil(mockRepository.astronautsResultMock)
    }

    func givenSetRepositoryToLoadSelectedAstronaut(result: Single<Astronaut>) {
        mockRepository.astronautByIdResultMock = result
        XCTAssertNotNil(mockRepository.astronautByIdResultMock)
    }

    func whenRetrievingAllAstronauts() {
        astronautsListPresenter.loadAstronauts()
    }

    func whenUserSelectAnAstronautWhenUserTapAnItem() {
        XCTAssertFalse(astronautsListPresenter.getAstronauts().isEmpty)
        let astronaut = astronautsListPresenter.getAstronaut(by: IndexPath(item: 0, section: 0))
        astronautsListPresenter.onSelect(astronaut: astronaut)
        XCTAssertNotNil(astronaut)
    }

    func thenDisplayLoadingStatus() {
        XCTAssertTrue(mockAstronautListView.showLoading)
    }

    func thenAllAstronautsAPIExecutionCompleted() {
        XCTAssertFalse(astronautsListPresenter.getAstronauts().isEmpty)
    }

    func thenAllAstronautsAPIExecutionCompletedWithoutResults() {
        XCTAssertTrue(astronautsListPresenter.getAstronauts().isEmpty)
    }

    func thenDisplayErrorMessage(for error: NetworkError) {
        XCTAssertEqual(mockAstronautListView.errorMessage, error.errorDescription)
    }

    func thenHideLoadingStatus() {
        XCTAssertTrue(mockAstronautListView.hideLoading)
    }

    func thenRetrievedAstronautsDisplayedInView() {
        XCTAssertTrue(mockAstronautListView.astronautsListReceived)
    }

    func thenAstronautDetailsDisplayed() {
        XCTAssertTrue(mockAstronautListView.astronautDetailsDisplyed)
    }

}
