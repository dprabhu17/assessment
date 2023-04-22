//
//  TestUtils.swift
//  AssessmentTests
//
//  Created by Prabhu on 21/04/23.
//

@testable import Assessment
import Foundation

struct TestUtils {
    static func loadMockFromJSON(fileName: String = "astronauts_mock") -> [Astronaut] {
       guard let url = Bundle.main.url(forResource: "astronauts_mock", withExtension: "json") else { return [] }
        if let data = try? Data(contentsOf: url) {
            if let response = try? JSONDecoder().decode(AstronautList.self, from: data) {
                return response.results
            }
       }
       return []
    }

    static func loadAstronautListFromJSON(fileName: String = "astronauts_mock") -> AstronautList {
       let list = AstronautList(results: [])
       guard let url = Bundle.main.url(forResource: "astronauts_mock", withExtension: "json") else { return list }
        if let data = try? Data(contentsOf: url) {
            if let response = try? JSONDecoder().decode(AstronautList.self, from: data) {
                return response
            }
       }
       return list
    }
}
