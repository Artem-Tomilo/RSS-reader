//
//  MainViewController.swift
//  rss-reader
//
//  Created by Артем Томило on 31.01.23.
//

import UIKit

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
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "123")
    }
}

extension MainViewController: UICollectionViewDelegate {
    
}

extension MainViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "123", for: indexPath)
        cell.backgroundColor = .white
        return cell
    }
}

extension MainViewController: MainViewProtocol {
    
}
