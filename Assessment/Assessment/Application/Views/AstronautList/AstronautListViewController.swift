//
//  AstronautListViewController.swift
//  Assessment
//
//  Created by Prabhu on 19/04/23.
//

import UIKit

class AstronautListViewController: UIViewController {

    // MARK: Properties
    let astronautsPresenter: AstronautListPresenter
    let astronautsDataSource: AstronautDataSource

    // MARK: UIElements
    @IBOutlet weak var tblAstronaut: UITableView!

    // MARK: Lifecycle methods
    init(astronautsPresenter: AstronautListPresenter,
         astronautsDataSource: AstronautDataSource) {

        self.astronautsPresenter = astronautsPresenter
        self.astronautsDataSource = astronautsDataSource
        super.init(nibName: String(describing: AstronautListViewController.self), bundle: nil)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        buildUI()
    }

}

// MARK: Instance Methods
extension AstronautListViewController {

    func initialize() {
        tblAstronaut.registerCell(type: AstronautCell.self)
        tblAstronaut.dataSource = astronautsDataSource
        tblAstronaut.delegate = astronautsDataSource
    }

    func buildUI() {
        title = AstronautListStrings.navTitle
        astronautsPresenter.attachView(astronautListView: self)
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

    func showErrorWith(message: String) {
        showAlert(message: message)
        reloadFilter()
    }

    func showDetail(for astronaut: Astronaut) {
        let astronautsPresenter = AstronautDetailPresenter(astronaut: astronaut)
        let astronautDetailViewController = AstronautDetailViewController(astronautsDetailPresenter: astronautsPresenter)
        self.navigationController?.pushViewController(astronautDetailViewController, animated: true)
    }

    @objc func filterRecords() {
        astronautsPresenter.showAstronautsBasedOnFilter()
    }
}
