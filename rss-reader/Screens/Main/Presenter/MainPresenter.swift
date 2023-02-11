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
    private let dataManager = CoreDataManager()
    private let userDefaults = UserDefaults.standard
    var news = [News]()
    var viewedNews = [String]()
    static let key = "viewedNewsKey"
    
    required init(view: MainViewProtocol, router: RouterProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
        fetchNews()
        self.viewedNews = loadViewedNews()
    }
    
    func fetchNews() {
        networkService.fetchNews { result in
            switch result {
            case .success(let news):
                self.news = news
                DispatchQueue.global(qos: .background).async {
                    self.news.forEach({self.dataManager.saveNews($0)})
                }
                self.view?.fetchNewsSuccess()
            case .failure(let error):
                self.news = self.dataManager.loadNews()
                self.view?.fetchNewsFailure(error: error)
            }
        }
    }
    
    func checkArticleViewed(with id: String) -> Bool {
        if viewedNews.contains(id) {
            return true
        }
        return false
    }
    
    func moveToNewsDetails(news: News) {
        router.moveToNewsDetails(news: news)
    }
    
    func saveViewedNews(_ news: [String]) {
        userDefaults.set(news, forKey: MainPresenter.key)
    }
    
    func loadViewedNews() -> [String] {
        let news = userDefaults.stringArray(forKey: MainPresenter.key)
        return news ?? []
    }
    
    func changeNewsSection(_ newsSection: NewsSection) {
        networkService.bindSection(newsSection.rawValue)
        self.view?.startIndicator()
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) {
            self.fetchNews()
        }
    }
}
