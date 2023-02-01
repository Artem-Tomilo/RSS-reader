//
//  AssemblyBuilderProtocol.swift
//  rss-reader
//
//  Created by Артем Томило on 31.01.23.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainViewController(router: RouterProtocol) -> UIViewController
    func createNewsDetailsViewController(news: News, router: RouterProtocol) -> UIViewController
}
