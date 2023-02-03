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
    var id: String
    
    init(title: String, description: String, date: String, pathForImage: String?) {
        self.title = title
        self.description = description
        self.date = date
        self.pathForImage = pathForImage
        self.id = (title.data(using: .utf8)?.base64EncodedString() ?? title) + (pathForImage?.data(using: .utf8)?.base64EncodedString() ?? "")
    }
}
