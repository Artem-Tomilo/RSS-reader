//
//  News.swift
//  rss-reader
//
//  Created by Артем Томило on 31.01.23.
//

import UIKit

struct News: Codable {
    var title: String
    var description: String
    var date: String
    var logo: String?
}
