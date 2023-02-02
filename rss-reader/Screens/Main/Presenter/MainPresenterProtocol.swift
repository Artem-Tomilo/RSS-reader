//
//  MainPresenterProtocol.swift
//  rss-reader
//
//  Created by Артем Томило on 31.01.23.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, router: RouterProtocol, networkService: NetworkServiceProtocol)
    var news: [News] { get }
    func fetchNews()
    func moveToNewsDetails(news: News)
    func isArticleViewed(in news: Set<News>, with id: Int) -> Bool
}
