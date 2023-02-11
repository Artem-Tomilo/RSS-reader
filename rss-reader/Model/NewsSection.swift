//
//  NewsSection.swift
//  rss-reader
//
//  Created by Артем Томило on 12.02.23.
//

import Foundation

enum NewsSection: String, CaseIterable {
    case news
    case top7
    case last24
    case articles
    case columns
}

extension NewsSection {
    var title: String {
        switch self {
        case .news:
            return "News"
        case .top7:
            return "Top 7"
        case .last24:
            return "Last 24"
        case .articles:
            return "Articles"
        case .columns:
            return "Columns"
        }
    }
}
