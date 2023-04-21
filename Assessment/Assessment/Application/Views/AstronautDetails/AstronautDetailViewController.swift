//
//  AstronautDetailViewController.swift
//  Assessment
//
//  Created by Prabhu on 20/04/23.
//

import UIKit

class AstronautDetailViewController: UIViewController {

    // MARK: Properties
    let astronautsDetailPresenter: AstronautDetailPresenter

    // MARK: UIElements
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var vwName: UIView!
    @IBOutlet weak var lblNationality: UILabel!
    @IBOutlet weak var vwNationality: UIView!
    @IBOutlet weak var lblDateOfBirth: UILabel!
    @IBOutlet weak var vwDateOfBirth: UIView!
    @IBOutlet weak var lblBiography: UILabel!
    @IBOutlet weak var vwBiography: UIView!
    @IBOutlet weak var vwContainer: UIView!

    // MARK: Lifecycle methods
    init(astronautsDetailPresenter: AstronautDetailPresenter) {
        self.astronautsDetailPresenter = astronautsDetailPresenter
        super.init(nibName: "AstronautDetailViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: Instance methods
extension AstronautDetailViewController {

    func buildUI() {
        imgProfile.setAsCircle()
        vwContainer.isHidden = true
        navigationController?.navigationBar.prefersLargeTitles = false
        astronautsDetailPresenter.attachView(astronautDetailView: self)
        astronautsDetailPresenter.loadAstronautProfile()
    }

}

// MARK: AstronautDetailView - Delegates
extension AstronautDetailViewController: AstronautDetailView {

    func showDetail(for model: Astronaut) {
        vwContainer.isHidden = false
        imgProfile.setImage(url: model.profileImageThumbnail)

        if let value = model.name {
            renderInfo(for: lblFirstName, value: value)
        }

        if let value = model.nationality {
            renderInfo(for: lblNationality, value: value)
        }

        if let value = model.dateOfBirth {
            renderInfo(for: lblDateOfBirth, value: value)
        }

        if let value = model.biography {
            renderInfo(for: lblBiography, value: value)
        }
    }

    func showErrorWith(message: String) {
        showAlert(message: message)
    }

    func renderInfo(for label: UILabel, value: String) {
        label.text = value
        label.superview?.isHidden = false
    }
}
