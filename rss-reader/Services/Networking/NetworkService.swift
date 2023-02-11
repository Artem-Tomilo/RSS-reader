//
//  NetworkService.swift
//  rss-reader
//
//  Created by Артем Томило on 1.02.23.
//

import Foundation
import Alamofire

class NetworkService: NetworkServiceProtocol {
    
    private let baseURL = "https://lenta.ru/rss/"
    private var newsSection = NewsSection.allCases.first?.rawValue
    
    func fetchNews(completion: @escaping(Result<[News], Error>) -> Void) {
        guard let newsSection else {
            completion(.failure(BaseError(message: "Failed to update data. Try again")))
            return
        }
        let urlString = baseURL + newsSection
        
        AF.request(urlString).responseData { response in
            do {
                if response.error != nil {
                    completion(.failure(BaseError(message: "Failed to update data. Try again")))
                }
                let data = try response.result.get()
                let parser = Parser()
                let xmlParser = XMLParser(data: data)
                xmlParser.delegate = parser
                xmlParser.parse()
                completion(.success(parser.unbindNews()))
            } catch {
                completion(.failure(BaseError(message: "An unexpected error occurred. Try again")))
            }
        }
    }
    
    func bindSection(_ text: String) {
        newsSection = text
    }
}
