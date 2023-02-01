//
//  Parser.swift
//  rss-reader
//
//  Created by Артем Томило on 31.01.23.
//

import Foundation

class Parser: NSObject, XMLParserDelegate {
    
    private var news: [News] = []
    
    private var currentNews = ""
    private var currentTitle: String = ""
    private var currentDescription: String = ""
    private var currentPubDate: String = ""
    private var currentImageURL: String = ""
    
    private var parserCompletionHandler: (([News]) -> Void)?
    
    func parseFeed(url: String, completionHandler: (([News]) -> Void)?) -> Void {
        self.parserCompletionHandler = completionHandler
        
        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            guard let data else {
                if let error {
                    print(error)
                }
                return
            }
            
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }
        task.resume()
    }
    
    // MARK: - XML Parser Delegate
    
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
                currentImageURL += urlString
            }
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentNews {
        case "title":
            currentTitle += string
        case "description":
            currentDescription += string
        case "pubDate":
            currentPubDate += string
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
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(news)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}
