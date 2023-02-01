//
//  AssemblyBuilder.swift
//  rss-reader
//
//  Created by Артем Томило on 31.01.23.
//

import UIKit

class AssemblyBuilder: AssemblyBuilderProtocol {
    
    func createMainViewController(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkService()
        let presenter = MainPresenter(view: view, router: router, networkService: networkService)
        view.presenter = presenter
        return view
    }
    
    func createNewsDetailsViewController(news: News, router: RouterProtocol) -> UIViewController {
        let view = NewsDetailsViewController()
        let presenter = NewsDetailsPresenter(view: view, router: router, news: news)
        view.presenter = presenter
        return view
    }
}
