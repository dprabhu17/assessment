//
//  NetworkConfig.swift
//  Assessment
//
//  Created by Prabhu on 19/04/23.
//

import Foundation

enum APIEndPoints {
    case austranautList
    case austranautDetails(id: Int)
}
extension APIEndPoints {
    private var baseURL: String {
        "https://spacelaunchnow.me/api/3.5.0"
    }
    private var path: String {
        switch self {
        case .austranautList: return "/astronaut"
        case .austranautDetails(let id): return "/astronaut/\(id)"
        }
    }
    var url: URL {
        let apiEndPoint = baseURL + self.path
        guard let url = URL(string: apiEndPoint) else { fatalError("URL is incorrect!") }
        return url
    }
}
