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
    func checkArticleViewed(with id: String) -> Bool
    func saveViewedNews(_ news: [String])
    func loadViewedNews() -> [String]
    func changeNewsSection(_ newsSection: NewsSection)
    var viewedNews: [String] { get set }
}
