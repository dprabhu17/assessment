//
//  MockHTTPClient.swift
//  AssessmentTests
//
//  Created by Prabhu on 21/04/23.
//

@testable import Assessment
import Foundation
import RxSwift

class MockHTTPServices<T: Decodable>: HTTPClient {

    // MARK: Properties
    private let reachability: ReachabilityProtocol
    var result: Single<T>!

    // MARK: Lifecycle methods
    public init(reachability: ReachabilityProtocol = Reachability()) {
        self.reachability = reachability
    }

    func load<T>(resource: Resource<T>) -> Single<T> {
        return Single<T>.create { [weak self] _ in
            _ = self?.result as? Single<T>
            return Disposables.create()
        }
    }

}
