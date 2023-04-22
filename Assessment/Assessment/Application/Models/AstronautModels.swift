//
//  AstronautModels.swift
//  Assessment
//
//  Created by Prabhu on 19/04/23.
//

import Foundation

// MARK: Astronaut - Model
public struct Astronaut: Decodable {
    let astronautId: Int
    let name: String
    let profileImage: String?
    let profileImageThumbnail: String?
    let nationality: String?
    let biography: String?
    let dateOfBirth: String?

    private enum CodingKeys: String, CodingKey {
        case astronautId = "id"
        case name
        case profileImage = "profile_image"
        case profileImageThumbnail = "profile_image_thumbnail"
        case nationality
        case biography = "bio"
        case dateOfBirth = "date_of_birth"
    }
}

// MARK: AstronautList - Model
public struct AstronautList: Decodable {
    let results: [Astronaut]
}
