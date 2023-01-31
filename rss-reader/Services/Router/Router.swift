//
//  Router.swift
//  rss-reader
//
//  Created by Артем Томило on 31.01.23.
//

import UIKit

class Router: RouterProtocol {
    var navigationController: UINavigationController
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        guard let viewController = assemblyBuilder?.createMainViewController(router: self) else { return }
        navigationController.viewControllers = [viewController]
    }
    
    func popViewController() {
        navigationController.popViewController(animated: true)
    }
}
