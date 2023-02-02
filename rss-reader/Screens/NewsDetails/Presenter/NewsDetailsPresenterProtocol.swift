//
//  NewsDetailsPresenterProtocol.swift
//  rss-reader
//
//  Created by Артем Томило on 1.02.23.
//

import Foundation

protocol NewsDetailsPresenterProtocol: AnyObject {
    init(view: NewsDetailsViewProtocol, router: RouterProtocol, news: News?)
    var news: News? { get }
    func backButtonTap()
}
