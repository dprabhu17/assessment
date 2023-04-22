//
//  UIViewController+Extensions.swift
//  Assessment
//
//  Created by Prabhu on 19/04/23.
//

import UIKit
extension UIViewController {

    // Displays activity indicator on current view
    func displaySpinner() {
        let spinnerView = UIView.init(frame: UIScreen.main.bounds)
        spinnerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3)
        spinnerView.tag = 999

        let activityIndicator = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true

        activityIndicator.center = spinnerView.center
        activityIndicator.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin, .flexibleLeftMargin, .flexibleBottomMargin]

         DispatchQueue.main.async { [weak self] in
            spinnerView.addSubview(activityIndicator)
             self?.view.addSubview(spinnerView)
        }
    }

    // Removes activity indicator
    func removeSpinner() {
        if let subViews = view.viewWithTag(999) {
            subViews.removeFromSuperview()
        }
    }

    // Shows alert with message
    func showAlert(message: String?, completion: (() -> Void)? = nil) {
        let title = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "Assignment"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: AstronautListStrings.okCTA, style: .default)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: completion)
    }
}
