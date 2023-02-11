//
//  NewsSectionCellProtocol.swift
//  rss-reader
//
//  Created by Артем Томило on 12.02.23.
//

import Foundation

protocol NewsSectionCellProtocol: AnyObject {
    func newsSectionTap(_ newsSection: NewsSection)
}
