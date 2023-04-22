//
//  AstronautsRepositoryTests.swift
//  AssessmentTests
//
//  Created by Prabhu on 21/04/23.
//

@testable import Assessment
import XCTest

final class AstronautsRepositoryTests: XCTestCase {

    // MARK: Properties
    var astronautsRepository: AstronautsRepository!

    // MARK: Properties
    func testGetAstronauts() {
        let httpServices = MockHTTPServices<[Astronaut]>(reachability: Reachability())
        httpServices.result = AstronautRepositoryMock.prepareAstronautsMock()
        astronautsRepository = AstronautsRepository(client: httpServices)
        XCTAssertNotNil(astronautsRepository.getAstronauts())
    }

    func test() {
        let httpServices = MockHTTPServices<[Astronaut]>(reachability: Reachability())
        httpServices.result = AstronautRepositoryMock.prepareAstronautsMock()
        astronautsRepository = AstronautsRepository(client: httpServices)
        if let astronaut = TestUtils.loadMockFromJSON().first {
            XCTAssertNotNil(astronautsRepository.getAstronaut(by: astronaut.astronautId))
        }
    }
}
