//
//  NewsDetailsViewProtocol.swift
//  rss-reader
//
//  Created by Артем Томило on 1.02.23.
//

import Foundation

protocol NewsDetailsViewProtocol: AnyObject {
    func fetchArticleSuccess()
    func fetchArticleFailure(error: Error)
}
