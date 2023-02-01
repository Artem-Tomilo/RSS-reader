//
//  RouterProtocol.swift
//  rss-reader
//
//  Created by Артем Томило on 31.01.23.
//

import UIKit

protocol RouterProtocol {
    var navigationController: UINavigationController { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
    func initialViewController()
    func moveToNewsDetails(news: News)
    func popViewController()
}
