//
//  File.swift
//  Assessment
//
//  Created by Prabhu on 19/04/23.
//

import Foundation
import RxSwift

public protocol HTTPClient {
    func load<T>(resource: Resource<T>) -> Single<T>
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

public struct Resource<T: Decodable> {
    let url: URL
    var httpMethod: HttpMethod = .get
    var body: Data?
}

extension Resource {
    init(url: URL) {
        self.url = url
    }
}

// MARK: An Adapter to make HTTP requests via URLSession with RxSwift
final class HTTPServices: HTTPClient {

    // MARK: Properties
    private let reachability: ReachabilityProtocol

    // MARK: Lifecycle methods
    public init(reachability: ReachabilityProtocol = Reachability()) {
        self.reachability = reachability
    }

    func load<T>(resource: Resource<T>) -> Single<T> {

        return Single<T>.create { [weak self] single in

            // Prepare request from resource
            var request = URLRequest(url: resource.url)
            request.httpMethod = resource.httpMethod.rawValue
            request.httpBody = resource.body
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            // print("🌐 Request: ", request.url?.absoluteString ?? "")

            // Check Internet Connection
            if let isNetworkAvailable = self?.reachability.isNetworkAvailable, !isNetworkAvailable {
                single(.failure(NetworkError.noNetworkFound))
            }

            // make api call via data task
            let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in

                // Check for Valid Domain
                guard let data = data, error == nil else {
                    single(.failure(NetworkError.domainError))
                    return
                }

                // 404
                if (response as? HTTPURLResponse)?.statusCode == 404 {
                    single(.failure(NetworkError.urlError))
                }

                // Perform Decoding with the Generic class
                let result = try? JSONDecoder().decode(T.self, from: String(decoding: data, as: UTF8.self).data(using: .utf8) ?? data)

                if let result = result {
                    DispatchQueue.main.async {
                        // print("🌐 Response: ", result)
                        single(.success(result))
                    }
                } else {
                    DispatchQueue.main.async {
                        single(.failure(NetworkError.decodingError))
                    }
                }

            }
            dataTask.resume()
            return Disposables.create { dataTask.cancel() }
        }
    }
}
