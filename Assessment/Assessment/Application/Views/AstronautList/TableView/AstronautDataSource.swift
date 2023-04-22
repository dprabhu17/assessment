//
//  AstronautDataSource.swift
//  Assessment
//
//  Created by Prabhu on 20/04/23.
//

import UIKit
class AstronautDataSource: NSObject {

    // MARK: Properties
    let presenter: AstronautListPresenter

    // MARK: Lifecycle methods
    public init(presenter: AstronautListPresenter) {
        self.presenter = presenter
    }

}

// MARK: Tableview - Data Source and Delegate
extension AstronautDataSource: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return tableView.setEmptyMessageForTableView(dataSource: presenter.getAstronauts(),
                                                     messageToDisplay: AstronautListStrings.noDataFound)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getAstronauts().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AstronautCell",
                                                 for: indexPath) as? AstronautCell
        cell?.model = presenter.getAstronaut(by: indexPath)
        cell?.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.onSelect(astronaut: presenter.getAstronaut(by: indexPath))
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // reduce download priority for invisible cells to increase performance
        let imageUrl = presenter.getAstronaut(by: indexPath).profileImageThumbnail
        CustomDownloadManager.shared.slowDownImageDownloadTaskfor(imageURL: imageUrl)
    }

    // Load image url only for visible cell to increase performance
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            if tableView.visibleCells.contains(cell) {
                self?.loadImageOnlyForVisibleCell(tableView: tableView, cell: cell, for: indexPath)
            }
        }
    }

    func loadImageOnlyForVisibleCell(tableView: UITableView, cell: UITableViewCell?, for indexPath: IndexPath) {

        // Choose upcoming cell and set placeholder image
        guard let cell = cell as? AstronautCell else { return }
        cell.image = UIImage.get(.placeholder)

        // Download image by using download manager
        let imageUrl = presenter.getAstronaut(by: indexPath).profileImageThumbnail
        CustomDownloadManager.shared.downloadImage(url: imageUrl,
                                                   indexPath: indexPath) { (image, _, downloadedIndex, _) in

            // Set downloaded image
            DispatchQueue.main.async {
                if let downloadedIndex = downloadedIndex,
                    let cell = tableView.cellForRow(at: downloadedIndex) as? AstronautCell {
                    cell.image = image
                }
            }

        }
    }
}
