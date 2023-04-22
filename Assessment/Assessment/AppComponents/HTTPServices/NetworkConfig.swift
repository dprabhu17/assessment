//
//  NetworkConfig.swift
//  Assessment
//
//  Created by Prabhu on 19/04/23.
//

import Foundation
// Network configuration to manage base url and path for RESTful web services.
enum APIEndPoints {
    case astronautList
    case astronautDetails(id: Int)
}
extension APIEndPoints {
    private var baseURL: String {
        "https://spacelaunchnow.me/api/3.5.0"
    }
    private var path: String {
        switch self {
        case .astronautList: return "/astronaut"
        case .astronautDetails(let id): return "/astronaut/\(id)"
        }
    }
    var url: URL {
        let apiEndPoint = baseURL + self.path
        guard let url = URL(string: apiEndPoint) else { fatalError("URL is incorrect!") }
        return url
    }
}
