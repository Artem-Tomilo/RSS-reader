//
//  NewsSectionCell.swift
//  rss-reader
//
//  Created by Артем Томило on 11.02.23.
//

import UIKit

class NewsSectionCell: UICollectionViewCell {
    
    private let label = UILabel()
    static let cellIdentifier = "newsSectionCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
//            make.leading.trailing.leading.bottom.equalToSuperview().inset(15)
            make.height.equalTo(30)
            make.width.equalTo(100)
            make.centerY.centerX.equalToSuperview()
        }
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        label.textColor = .black
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 0.3
    }
    
    func bind(_ text: String) {
        label.text = text
    }
}
