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
            if let error = response.error {
                completion(.failure(error))
            }
            guard let data = response.data else { return }
            let parser = Parser()
            let xmlParser = XMLParser(data: data)
            xmlParser.delegate = parser
            xmlParser.parse()
            completion(.success(parser.unbindNews()))
        }
    }
}
