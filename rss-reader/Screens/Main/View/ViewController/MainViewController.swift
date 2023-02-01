//
//  MainViewController.swift
//  rss-reader
//
//  Created by Артем Томило on 31.01.23.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    var presenter: MainPresenterProtocol?
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureCollectionView()
    }
    
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
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
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
}

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
        
        let url = URL(string: news.logo!)
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                print(error.localizedDescription)
            }
            guard let data else { return }
            DispatchQueue.main.async {
                cell.bind(title: news.title, date: news.date, image: UIImage(data: data))
            }
        }
        task.resume()
        
        return cell
    }
}

extension MainViewController: MainViewProtocol {
    
    func fetchNewsSuccess() {
        self.collectionView?.reloadData()
    }
    func fetchNewsFailure(error: Error) {
        
    }
}
