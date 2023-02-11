//
//  MainViewController.swift
//  rss-reader
//
//  Created by Артем Томило on 31.01.23.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    //MARK: - Properties
    
    var presenter: MainPresenterProtocol?
    private var collectionView: UICollectionView?
    private let activityIndicator = ActivityIndicator()
    private let refreshControl = UIRefreshControl()
    
    //MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Configure UI
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.barStyle = .black
        let navBar = navigationController?.navigationBar
        navBar?.isTranslucent = false
        navBar?.barTintColor = .black
        
        let leftTitle = UILabel()
        leftTitle.font = UIFont.boldSystemFont(ofSize: 30)
        leftTitle.text = "News"
        leftTitle.textColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftTitle)
    }
    
    private func configureCollectionView() {
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView else { return }
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        collectionView.register(NewsCell.self,
                                forCellWithReuseIdentifier: NewsCell.cellIdentifier)
        collectionView.register(NewsSectionCell.self,
                                forCellWithReuseIdentifier: NewsSectionCell.cellIdentifier)
    }
    
    private func configureSubViews() {
        guard let collectionView else { return }
        refreshControl.addTarget(self, action: #selector(update(_:)), for: .primaryActionTriggered)
        collectionView.refreshControl = refreshControl
        
        let updateButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(update(_:)))
        updateButton.tintColor = .white
        navigationItem.rightBarButtonItem = updateButton
        
        activityIndicator.displayIndicator(view: collectionView)
        activityIndicator.startAnimating()
    }
    
    private func configureUI() {
        configureNavigationBar()
        configureCollectionView()
        configureSubViews()
    }
    
    //MARK: - Handle error
    
    private func handleError(error: Error) {
        let baseError = error as! BaseError
        showAlertController(message: baseError.message, viewController: self)
    }
    
    //MARK: - Targets
    
    @objc func update(_ sender: Any) {
        presenter?.fetchNews()
        refreshControl.endRefreshing()
    }
}

//MARK: - extension CollectionView

extension MainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? NewsCell else { return }
        guard let presenter else { return }
        let article = presenter.news[indexPath.row]
        cell.newsIsOpen()
        presenter.moveToNewsDetails(news: article)
        
        if !presenter.checkArticleViewed(with: article.id) {
            presenter.viewedNews.append(article.id)
            presenter.saveViewedNews(presenter.viewedNews)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 1
        let paddingWidth = itemsPerRow + 1
        let availableWidth = UIScreen.main.bounds.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        
        switch indexPath.section {
        case 0:
            return CGSize(width: widthPerItem, height: 80)
        default:
            return CGSize(width: widthPerItem, height: 120)
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return presenter?.news.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsSectionCell.cellIdentifier,
                                                                for: indexPath) as? NewsSectionCell else {
                return UICollectionViewCell()
            }
            return cell
            
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.cellIdentifier,
                                                                for: indexPath) as? NewsCell else { return UICollectionViewCell() }
            guard let presenter else { return cell }
            let article = presenter.news[indexPath.item]
            
            if presenter.checkArticleViewed(with: article.id) {
                DispatchQueue.main.async {
                    cell.newsIsOpen()
                }
            }
            cell.bind(article)
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}

//MARK: - extension MainViewProtocol

extension MainViewController: MainViewProtocol {
    
    func fetchNewsSuccess() {
        self.activityIndicator.stopAnimating()
        self.collectionView?.reloadData()
    }
    
    func fetchNewsFailure(error: Error) {
        activityIndicator.stopAnimating()
        handleError(error: error)
        self.collectionView?.reloadData()
    }
}
