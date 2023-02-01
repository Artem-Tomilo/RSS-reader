//
//  TitleTableViewCell.swift
//  rss-reader
//
//  Created by Артем Томило on 1.02.23.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    private let logo = UIImageView()
    private let titleView = UIView()
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let activityIndicator = ActivityIndicator()
    static let cellIdentifier = "newsDetails"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addingSubviewsAndSettingConstraints()
        configureSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addingSubviewsAndSettingConstraints() {
        contentView.addSubview(logo)
        logo.addSubview(titleView)
        titleView.addSubview(titleLabel)
        titleView.addSubview(dateLabel)
        
        logo.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.greaterThanOrEqualTo(80)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(dateLabel.snp.top)
            make.top.equalToSuperview().offset(10)
        }
    }
    
    private func configureSubViews() {
        logo.clipsToBounds = true
        logo.contentMode = .scaleAspectFill
        
        titleView.backgroundColor = UIColor(cgColor: CGColor(red: 0, green: 0, blue: 0, alpha: 0.5))
        
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.numberOfLines = 0
        
        dateLabel.textColor = .white
        dateLabel.font = UIFont.systemFont(ofSize: 13)
        dateLabel.alpha = 0.7
        
        activityIndicator.displayIndicator(view: logo)
        activityIndicator.startAnimating()
    }
    
    func bind(_ news: News) {
        let dateFormatter = DateFormatter()
        titleLabel.text = news.title
        dateLabel.text = dateFormatter.getNewDate(string: news.date)
        
        if let path = news.logo {
            logo.sd_setImage(with: URL(string: path)) { (image, error, cache, url) in
                self.activityIndicator.stopAnimating()
            }
        }
    }
}
