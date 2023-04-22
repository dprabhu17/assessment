//
//  AstronautRepositoryMock.swift
//  AssessmentTests
//
//  Created by Prabhu on 21/04/23.
//

@testable import Assessment
import Foundation
import RxSwift
class AstronautRepositoryMock: Repository {

    var astronautsResultMock: Single<[Astronaut]>!
    var astronautByIdResultMock: Single<Astronaut>!

    func getAstronaut(by id: Int) -> Single<Astronaut> {
        return astronautByIdResultMock
    }

    func getAstronauts() -> Single<[Astronaut]> {
        return astronautsResultMock
    }
}

extension AstronautRepositoryMock {

    static func prepareAstronautListMock() -> Single<AstronautList> {
        return Single<AstronautList>.create { single in
            let results = TestUtils.loadAstronautListFromJSON()
            single(.success(results))
            return Disposables.create()
        }
    }

    static func prepareAstronautsMock() -> Single<[Astronaut]> {
        return Single<[Astronaut]>.create { single in
            // sleep(2)
            let results = TestUtils.loadMockFromJSON()
            single(.success(results))
            return Disposables.create()
        }
    }

    static func prepareErrorMockForAstronautsMock(error: NetworkError) -> Single<[Astronaut]> {
        return Single<[Astronaut]>.create { single in
            single(.failure(error))
            return Disposables.create()
        }
    }

    static func prepareMockForAstronautById() -> Single<Astronaut> {
        return Single<Astronaut>.create { single in
            // sleep(2)
            if let astronaut = TestUtils.loadMockFromJSON().first {
                single(.success(astronaut))
            } else {
                single(.failure(NetworkError.decodingError))
            }
            return Disposables.create()
        }
    }

    static func prepareErrorMockForAstronautById(error: NetworkError) -> Single<Astronaut> {
        return Single<Astronaut>.create { single in
            single(.failure(error))
            return Disposables.create()
        }
    }
}
