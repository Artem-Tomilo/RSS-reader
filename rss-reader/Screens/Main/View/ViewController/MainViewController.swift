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
        configureNavigationBar()
        configureCollectionView()
        configureSubViews()
    }
    
    //MARK: - View settings
    
    private func configureNavigationBar(){
        navigationController?.navigationBar.barStyle = .black
        let navBar = navigationController?.navigationBar
        navBar?.isTranslucent = false
        navBar?.barTintColor = .red
        
        let leftTitle = UILabel()
        leftTitle.font = UIFont.boldSystemFont(ofSize: 30)
        leftTitle.text = "News"
        leftTitle.textColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftTitle)
    }
    
    private func configureCollectionView() {
        view.backgroundColor = .white
        
        let itemsPerRow: CGFloat = 1
        let paddingWidth = itemsPerRow + 1
        let availableWidth = UIScreen.main.bounds.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: widthPerItem, height: 100)
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
                                forCellWithReuseIdentifier: NewsCell.cellIdintifier)
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
    
    //MARK: - Targets
    
    @objc func update(_ sender: Any) {
        presenter?.fetchNews()
        refreshControl.endRefreshing()
    }
}

//MARK: - extension CollectionView

extension MainViewController: UICollectionViewDelegate {
    
}

extension MainViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.news.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.cellIdintifier,
                                                            for: indexPath) as? NewsCell else { return UICollectionViewCell() }
        let news = presenter?.news[indexPath.item]
        guard let news else { return cell }
        cell.bind(news: news)
        return cell
    }
}

//MARK: - extension MainViewProtocol

extension MainViewController: MainViewProtocol {
    
    func fetchNewsSuccess() {
        self.activityIndicator.stopAnimating()
        self.collectionView?.reloadData()
    }
    
    func fetchNewsFailure(error: Error) {
        
    }
}
