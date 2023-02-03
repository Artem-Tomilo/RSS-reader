//
//  BaseError.swift
//  rss-reader
//
//  Created by Артем Томило on 3.02.23.
//

import Foundation

struct BaseError: Error {
    
    var message: String
    
    init(message: String) {
        self.message = message
    }
}
