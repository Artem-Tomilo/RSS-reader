//
//  MainPresenter.swift
//  rss-reader
//
//  Created by Артем Томило on 31.01.23.
//

import Foundation

class MainPresenter: MainPresenterProtocol {
    
    private weak var view: MainViewProtocol?
    
    required init(view: MainViewProtocol) {
        self.view = view
    }
    
    
}
