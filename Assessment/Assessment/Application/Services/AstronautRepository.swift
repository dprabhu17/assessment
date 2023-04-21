//
//  AstronautRepository.swift
//  Assessment
//
//  Created by Prabhu on 19/04/23.
//

import Foundation
import RxSwift

public protocol Repository {
    func getAstronaut(by id: Int) -> Single<Astronaut>
    func getAstronauts() -> Single<[Astronaut]>
}

class AstronautsRepository {

    // MARK: Properties
    private let client: HTTPClient

    // MARK: Lifecycle methods
    public init(client: HTTPClient) {
        self.client = client
    }
}

// MARK: Implement Repository methods
extension AstronautsRepository: Repository {

    // Get an astronauts by id
    func getAstronaut(by id: Int) -> Single<Astronaut> {
        let resource = Resource<Astronaut>(url: APIEndPoints.austranautDetails(id: id).url)
        return client.load(resource: resource)
    }

    // Get all astronauts
    func getAstronauts() -> Single<[Astronaut]> {
        let resource = Resource<AstronautList>(url: APIEndPoints.austranautList.url)
        return client.load(resource: resource).map({ $0.results })
    }
}
