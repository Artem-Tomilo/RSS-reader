//
//  extension+DateFormatter.swift
//  rss-reader
//
//  Created by Артем Томило on 1.02.23.
//

import Foundation

extension DateFormatter {
    
    private func translateStringToDate(string: String) -> Date? {
        dateFormat = "EEE, dd MMM yyyy HH:mm:ss ZZZ"
        locale = Locale(identifier: "en_US")
        let date = date(from: string)
        return date
    }
    
    private func translateDateToString(date: Date) -> String {
        locale = Locale(identifier: "ru")
        dateFormat = "dd MMM yyyy HH:mm"
        let newString = self.string(from: date)
        return newString
    }
    
    func getNewDate(string: String) -> String {
        let date = translateStringToDate(string: string)
        guard let date else { return "" }
        let newString = translateDateToString(date: date)
        return newString
    }
}
