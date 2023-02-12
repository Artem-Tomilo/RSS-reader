//
//  NewsSectionCell.swift
//  rss-reader
//
//  Created by Артем Томило on 11.02.23.
//

import UIKit

class NewsSectionCell: UICollectionViewCell {
    
    private var collectionView: UICollectionView?
    weak var delegate: NewsSectionCellProtocol?
    static let cellIdentifier = "newsSectionCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.backgroundColor = .white
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 120, height: 30)
        flowLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        guard let collectionView else { return }
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        
        contentView.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        collectionView.register(NewsSectionItemCell.self, forCellWithReuseIdentifier: NewsSectionItemCell.cellIdetntifier)
        
        let indexPathForFirstRow = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: indexPathForFirstRow, animated: true, scrollPosition: [])
    }
}

extension NewsSectionCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NewsSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsSectionItemCell.cellIdetntifier,
                                                            for: indexPath) as? NewsSectionItemCell else { return UICollectionViewCell() }
        
        let newsSectionItem = NewsSection.allCases[indexPath.item].title
        cell.bind(newsSectionItem)
        return cell
    }
}

extension NewsSectionCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newsSection = NewsSection.allCases[indexPath.item]
        delegate?.newsSectionTap(newsSection)
    }
}
