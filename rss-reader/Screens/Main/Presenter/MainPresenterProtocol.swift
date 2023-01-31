//
//  MainPresenterProtocol.swift
//  rss-reader
//
//  Created by Артем Томило on 31.01.23.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, router: RouterProtocol)
    var news: [News] { get set }
}
