//
//  NewsDetailsViewController.swift
//  rss-reader
//
//  Created by Артем Томило on 1.02.23.
//

import UIKit

class NewsDetailsViewController: UIViewController {
    
    //MARK: - Properties
    
    var presenter: NewsDetailsPresenterProtocol?
    private let newsView = NewsDetailsView()
    
    //MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureNewsView()
    }
    
    //MARK: - View settings
    
    private func configureNavigationBar() {
        let leftTitle = UILabel()
        leftTitle.font = UIFont.boldSystemFont(ofSize: 30)
        leftTitle.text = "Details"
        leftTitle.textColor = .white
        
        let backButton = UIButton(type: .custom)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.tintColor = .white
        let image = UIImageView(image: UIImage(named: "BackButton")?.withRenderingMode(.alwaysTemplate))
        image.tintColor = .white
        backButton.setImage(image.image, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped(_:)), for: .primaryActionTriggered)
        
        let firstItem = UIBarButtonItem(customView: backButton)
        let fixedSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace,
                                                          target: nil, action: nil)
        fixedSpace.width = 10.0
        let secondItem = UIBarButtonItem(customView: leftTitle)
        navigationItem.leftBarButtonItems = [firstItem, fixedSpace, secondItem]
    }
    
    private func configureNewsView() {
        view.backgroundColor = .white
        view.addSubview(newsView)
        newsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        guard let news = presenter?.news else {
            fetchArticleFailure(error: BaseError(message: "Failed to load news, please try again"))
            return
        }
        newsView.bind(news)
    }
    
    private func handleError(error: Error) {
        let baseError = error as! BaseError
        showAlertController(message: baseError.message, viewController: self)
    }
    
    //MARK: - Targets
    
    @objc func backButtonTapped(_ sender: UIButton) {
        presenter?.backButtonTap()
    }
}

//MARK: - extension NewsDetailsViewProtocol

extension NewsDetailsViewController: NewsDetailsViewProtocol {
    
    func fetchArticleSuccess() {
        newsView.stopIndicator()
    }
    
    func fetchArticleFailure(error: Error) {
        newsView.stopIndicator()
        handleError(error: error)
    }
}
