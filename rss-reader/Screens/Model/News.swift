//
//  News.swift
//  rss-reader
//
//  Created by Артем Томило on 31.01.23.
//

import UIKit

struct News: Codable, Hashable {
    var title: String
    var description: String
    var date: String
    var pathForImage: String?
    var id: Int
    var isSelected: Bool = false
    static var counter = 0
    
    init(title: String, description: String, date: String, pathForImage: String? = nil) {
        self.title = title
        self.description = description
        self.date = date
        self.pathForImage = pathForImage
        self.id = News.counter
        News.counter += 1
    }
}
