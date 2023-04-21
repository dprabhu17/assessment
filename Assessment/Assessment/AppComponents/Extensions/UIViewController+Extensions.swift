//
//  UIViewController+Extensions.swift
//  Assessment
//
//  Created by Prabhu on 19/04/23.
//

import UIKit
extension UIViewController {

    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        return instantiateFromNib()
    }

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

    func removeSpinner() {
        if let subViews = view.viewWithTag(999) {
            subViews.removeFromSuperview()
        }
    }

    func showAlert(message: String, completion: (() -> Void)? = nil) {
        let title = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "Assignment"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: AstronautListStrings.okCTA, style: .default)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: {
            guard let callback = completion else { return }
            DispatchQueue.main.async {
                callback()
            }
        })
    }
}
