//
//  AstronautListViewController.swift
//  Assessment
//
//  Created by Prabhu on 19/04/23.
//

import UIKit
import RxSwift

// View conroller to display list of astronauts
class AstronautListViewController: UIViewController {

    // MARK: Properties
    let astronautsPresenter: AstronautListPresenter
    let astronautsDataSource: AstronautDataSource
    let coordinator: Coordinator

    // MARK: UIElements
    @IBOutlet weak var tblAstronaut: UITableView!

    // MARK: Lifecycle methods
    init(astronautsPresenter: AstronautListPresenter,
         astronautsDataSource: AstronautDataSource,
         coordinator: Coordinator) {

        self.astronautsPresenter = astronautsPresenter
        self.astronautsDataSource = astronautsDataSource
        self.coordinator = coordinator
        super.init(nibName: String(describing: AstronautListViewController.self), bundle: nil)

    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        buildUI()
    }

}

// MARK: Instance Methods
private extension AstronautListViewController {

    func initialize() {
        tblAstronaut.registerCell(type: AstronautCell.self)
        tblAstronaut.dataSource = astronautsDataSource
        tblAstronaut.delegate = astronautsDataSource
    }

    func buildUI() {
        title = AstronautListStrings.navTitle
        astronautsPresenter.loadAstronauts()
        setFilterButtonOnTop()
    }

    func setFilterButtonOnTop() {
        let filterButton = UIBarButtonItem(title: nil,
                                           image: UIImage.get(.iconFilterDisabled),
                                           target: self, action: #selector(filterRecords))
        navigationItem.rightBarButtonItems = [filterButton]
        reloadFilter()
    }

    func reloadFilter() {
        let filterImage = astronautsPresenter.filteredByName ? UIImage.get(.iconFilterEnabled) : UIImage.get(.iconFilterDisabled)
        navigationItem.rightBarButtonItems?.first?.image = filterImage
        navigationItem.rightBarButtonItem?.isHidden = astronautsPresenter.getAstronauts().isEmpty
    }

}

// MARK: Presenter View - Delegates
extension AstronautListViewController: AstronautListView {

    func showLoadingStatus() {
        displaySpinner()
    }

    func hideLoadingStatus() {
        removeSpinner()
    }

    func reloadData() {
        tblAstronaut.reloadData()
        reloadFilter()
    }

    func showErrorWith(message: String?) {
        showAlert(message: message)
        reloadFilter()
    }

    func showDetail(for astronaut: Astronaut) {
        coordinator.showAstronautDetails(for: astronaut)
    }

    @objc func filterRecords() {
        astronautsPresenter.showAstronautsBasedOnFilter()
    }
}
