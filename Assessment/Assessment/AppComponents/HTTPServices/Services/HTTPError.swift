//
//  HTTPError.swift
//  Assessment
//
//  Created by Prabhu on 19/04/23.
//

import Foundation

public enum NetworkError: Error {
    case noNetworkFound
    case decodingError
    case domainError
    case urlError
}

extension Error {
    var errorDescription: String {
        (self as? NetworkError)?.description ?? ""
    }
}

extension NetworkError {
    var description: String? {
        switch self {
        case .noNetworkFound:
            return ErrorStrings.noNetworkFound

        case .decodingError:
            return ErrorStrings.decodingError

        case .domainError:
            return ErrorStrings.domainError

        case .urlError:
            return ErrorStrings.urlError
        }
    }
}
