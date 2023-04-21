//
//  AstronautDetailView.swift
//  Assessment
//
//  Created by Prabhu on 20/04/23.
//

import Foundation
// MARK: Protocol for astronaut detail view controller's presenter
protocol AstronautDetailView: AnyObject {
    func showErrorWith(message: String)
    func showDetail(for model: Astronaut)
}
