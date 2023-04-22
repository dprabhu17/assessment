//
//  AstronautListView.swift
//  Assessment
//
//  Created by Prabhu on 19/04/23.
//

import Foundation
// MARK: Protocol for astronaut list view controller's presenter
public protocol AstronautListView: AnyObject {
    func filterRecords()
    func showLoadingStatus()
    func hideLoadingStatus()
    func reloadData()
    func showErrorWith(message: String?)
    func showDetail(for astronaut: Astronaut)
}
