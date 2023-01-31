//
//  NewsCell.swift
//  rss-reader
//
//  Created by Артем Томило on 31.01.23.
//

import UIKit

class NewsCell: UICollectionViewCell {
    
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let logo = UIImageView()
    static let cellIdintifier = "newsCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addingSubviewsAndSettingConstraints()
        configureSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addingSubviewsAndSettingConstraints() {
        contentView.backgroundColor = .white
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(logo)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(5)
            make.trailing.equalTo(logo.snp.leading).offset(-5)
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(titleLabel.snp.width)
        }
        
        logo.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview().inset(15)
            make.width.equalTo(logo.snp.height)
        }
        logo.backgroundColor = .cyan
    }
    
    private func configureSubViews() {
        titleLabel.backgroundColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        dateLabel.backgroundColor = .white
        dateLabel.textColor = .black
        dateLabel.font = UIFont.systemFont(ofSize: 13)
        dateLabel.alpha = 0.7
    }
    
    func bind(title: String, date: String, image: UIImage?) {
        titleLabel.text = title
        dateLabel.text = date
        if let image {
            self.logo.image = image
        }
    }
}
