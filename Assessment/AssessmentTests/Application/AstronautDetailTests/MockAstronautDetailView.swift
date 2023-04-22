//
//  MockAstronautDetailView.swift
//  AssessmentTests
//
//  Created by Prabhu on 21/04/23.
//

@testable import Assessment
import Foundation

class MockAstronautDetailView {

    // MARK: Properties
    var astronautDetailsDisplyed = false
}

// MARK: AstronautDetailView - Delegates
extension MockAstronautDetailView: AstronautDetailView {
    func showDetail(for model: Assessment.Astronaut) {
        astronautDetailsDisplyed = true
    }
}
