//
//  NewsDetailsViewController.swift
//  rss-reader
//
//  Created by Артем Томило on 1.02.23.
//

import UIKit

class NewsDetailsViewController: UIViewController {
    
    var presenter: NewsDetailsPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
    }
}

extension NewsDetailsViewController: NewsDetailsViewProtocol {
    
}
