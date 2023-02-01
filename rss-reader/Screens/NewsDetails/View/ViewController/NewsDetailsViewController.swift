//
//  NewsDetailsViewController.swift
//  rss-reader
//
//  Created by Артем Томило on 1.02.23.
//

import UIKit

class NewsDetailsViewController: UIViewController {
    
    //MARK: - Properties
    
    var presenter: NewsDetailsPresenterProtocol?
    private let tableView = UITableView()
    
    //MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    //MARK: - View settings
    
    private func configureTableView() {
        navigationController?.navigationBar.tintColor = .white
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.cellIdentifier)
        tableView.backgroundColor = .clear
    }
}

//MARK: - Targets

//MARK: - extension CollectionView

extension NewsDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height * 0.6
    }
}

extension NewsDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.cellIdentifier,
                                                       for: indexPath) as? TitleTableViewCell else { return UITableViewCell() }
        guard let news = presenter?.news else { return cell }
        cell.bind(news)
        return cell
    }
}

//MARK: - extension NewsDetailsViewProtocol

extension NewsDetailsViewController: NewsDetailsViewProtocol {
    
}
