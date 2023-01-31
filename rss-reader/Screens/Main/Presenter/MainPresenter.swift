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
    
    required init(view: MainViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    
}
