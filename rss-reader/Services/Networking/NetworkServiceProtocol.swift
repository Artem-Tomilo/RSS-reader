//
//  NetworkServiceProtocol.swift
//  rss-reader
//
//  Created by Артем Томило on 1.02.23.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchNews(completion: @escaping(Result<[News], Error>) -> Void)
}
