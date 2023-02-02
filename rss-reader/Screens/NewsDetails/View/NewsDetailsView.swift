//
//  NewsDetailsView.swift
//  rss-reader
//
//  Created by Артем Томило on 2.02.23.
//

import UIKit

class NewsDetailsView: UIView {
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let titleView = UIView()
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let logo = UIImageView()
    private let activityIndicator = ActivityIndicator()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollView()
        addingSubviewsAndSettingConstraints()
        configureSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupScrollView() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }
        
        scrollView.bounces = false
        scrollView.backgroundColor = .white
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 30
    }
    
    private func addingSubviewsAndSettingConstraints() {
        stackView.addArrangedSubview(logo)
        stackView.addArrangedSubview(descriptionLabel)
        logo.addSubview(titleView)
        
        titleView.addSubview(titleLabel)
        titleView.addSubview(dateLabel)
        
        logo.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(snp.height).multipliedBy(0.6)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
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
        
        descriptionLabel.backgroundColor = .white
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .black
        descriptionLabel.font = UIFont.systemFont(ofSize: 22, weight: .light)
        
        activityIndicator.displayIndicator(view: logo)
        activityIndicator.startAnimating()
    }
    
    func bind(_ news: News) {
        let dateFormatter = DateFormatter()
        titleLabel.text = news.title
        dateLabel.text = dateFormatter.getNewDate(string: news.date)
        descriptionLabel.text = news.description
        
        if let path = news.pathForImage {
            logo.sd_setImage(with: URL(string: path)) { (image, error, cache, url) in
                self.activityIndicator.stopAnimating()
            }
        }
    }
}
