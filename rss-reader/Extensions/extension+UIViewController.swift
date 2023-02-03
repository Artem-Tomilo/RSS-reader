//
//  extension+UIViewController.swift
//  rss-reader
//
//  Created by Артем Томило on 3.02.23.
//

import UIKit

extension UIViewController {
    func showAlertController(message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .destructive, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
