//
//  NewsSectionItemCell.swift
//  rss-reader
//
//  Created by Артем Томило on 11.02.23.
//

import UIKit

class NewsSectionItemCell: UICollectionViewCell {
    
    private let label = UILabel()
    static let cellIdetntifier = "newsSectionItemCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            self.isSelected ? cellIsSelected() : cellIsNotSelected()
        }
    }
    
    private func configureUI() {
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        label.textColor = .black
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 0.3
        label.clipsToBounds = true
    }
    
    private func cellIsSelected() {
        label.backgroundColor = .black
        label.textColor = .white
    }
    
    private func cellIsNotSelected() {
        label.backgroundColor = .white
        label.textColor = .black
    }
    
    func bind(_ text: String) {
        label.text = text
    }
}
