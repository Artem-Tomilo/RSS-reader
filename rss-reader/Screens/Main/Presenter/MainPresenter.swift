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
    private let networkService: NetworkServiceProtocol
    var news = [News]()
    
    required init(view: MainViewProtocol, router: RouterProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
        fetchNews()
    }
    
    func fetchNews() {
        networkService.fetchNews { result in
            switch result {
            case .success(let news):
                self.news = news
                self.view?.fetchNewsSuccess()
            case .failure(let error):
                self.view?.fetchNewsFailure(error: error)
            }
        }
    }
    
    func isArticleViewed(in news: Set<News>, with id: Int) -> Bool {
        for i in news {
            if i.id == id {
                return true
            }
        }
        return false
    }
    
    func moveToNewsDetails(news: News) {
        router.moveToNewsDetails(news: news)
    }
}
