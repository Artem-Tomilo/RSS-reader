//
//  MainViewProtocol.swift
//  rss-reader
//
//  Created by Артем Томило on 31.01.23.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func fetchNewsSuccess()
    func fetchNewsFailure(error: Error)
    func startIndicator()
}
