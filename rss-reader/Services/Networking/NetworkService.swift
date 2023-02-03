//
//  NetworkService.swift
//  rss-reader
//
//  Created by Артем Томило on 1.02.23.
//

import Foundation
import Alamofire

class NetworkService: NetworkServiceProtocol {
    
    func fetchNews(completion: @escaping(Result<[News], Error>) -> Void) {
        let urlString = "https://lenta.ru/rss"
        
        AF.request(urlString).responseData { response in
            do {
                if response.error != nil {
                    completion(.failure(BaseError(message: "An unexpected error occurred. Try again")))
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
}
