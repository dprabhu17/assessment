//
//  MockAstronautListView.swift
//  AssessmentTests
//
//  Created by Prabhu on 21/04/23.
//

@testable import Assessment
import Foundation

class MockAstronautListView {

    // MARK: Properties
    var filteredRecords = false
    var showLoading = false
    var hideLoading = false
    var astronautsListReceived = false
    var errorMessage = ""
    var astronautDetailsDisplyed = false

}
extension MockAstronautListView: AstronautListView {

    func filterRecords() {
        filteredRecords = true
    }

    func showLoadingStatus() {
        showLoading = true
    }

    func hideLoadingStatus() {
        hideLoading = true
    }

    func reloadData() {
        astronautsListReceived = true
    }

    func showErrorWith(message: String?) {
        errorMessage = message ?? ""
    }

    func showDetail(for astronaut: Astronaut) {
        astronautDetailsDisplyed = true
    }

    func reset() {
        filteredRecords = false
        showLoading = false
        hideLoading = false
        astronautsListReceived = false
        astronautDetailsDisplyed = false
        errorMessage = ""
    }
}
