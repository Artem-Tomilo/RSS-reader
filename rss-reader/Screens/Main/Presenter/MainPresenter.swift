//
//  MainPresenter.swift
//  rss-reader
//
//  Created by Артем Томило on 31.01.23.
//

import Foundation

class MainPresenter: MainPresenterProtocol {
    
    private weak var view: MainViewProtocol?
    private let router: RouterProtocol
    var news = [News]()
    
    required init(view: MainViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
        fetchNews()
    }
    
    func fetchNews() {
        let parser = Parser()
        parser.parseFeed(url: "https://lenta.ru/rss") { [weak self] news in
            guard let self else { return }
            self.news = news
            DispatchQueue.main.async {
                self.view?.fetchNewsSuccess()
            }
        }
    }
    
}
