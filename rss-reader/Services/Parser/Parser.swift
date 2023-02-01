//
//  Parser.swift
//  rss-reader
//
//  Created by Артем Томило on 31.01.23.
//

import Foundation

class Parser: NSObject {
    
    private var news: [News] = []
    
    private var currentNews = ""
    private var currentTitle: String = ""
    private var currentDescription: String = ""
    private var currentPubDate: String = ""
    private var currentImageURL: String = ""
    
    func unbindNews() -> [News] {
        return news
    }
}

// MARK: - XML Parser Delegate

extension Parser: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?,
                qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentNews = elementName
        
        switch elementName {
        case "item":
            currentTitle = ""
            currentDescription = ""
            currentPubDate = ""
            currentImageURL = ""
        case "enclosure":
            if let urlString = attributeDict["url"] {
                currentImageURL += urlString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            }
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentNews {
        case "title":
            currentTitle += string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        case "description":
            currentDescription += string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        case "pubDate":
            currentPubDate += string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let news = News(title: currentTitle, description: currentDescription, date: currentPubDate, logo: currentImageURL)
            self.news += [news]
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}
