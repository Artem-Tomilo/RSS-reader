//
//  NewsDetailsPresenter.swift
//  rss-reader
//
//  Created by Артем Томило on 1.02.23.
//

import Foundation

class NewsDetailsPresenter: NewsDetailsPresenterProtocol {
    
    weak var view: NewsDetailsViewProtocol?
    private let router: RouterProtocol
    var news: News?
    
    required init(view: NewsDetailsViewProtocol, router: RouterProtocol, news: News?) {
        self.view = view
        self.router = router
        self.news = news
    }
    
    func backButtonTap() {
        router.popViewController()
    }
}
