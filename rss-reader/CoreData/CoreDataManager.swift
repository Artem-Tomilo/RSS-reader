//
//  CoreDataManager.swift
//  rss-reader
//
//  Created by Артем Томило on 3.02.23.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    private var savedNews = [SavedNews]()
    private var moc: NSManagedObjectContext?
    private let fetchRequest = SavedNews.fetchRequest()
    
    init() {
        configureMoc()
    }
    
    private func configureMoc() {
        moc = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        savedNews = (try? moc?.fetch(fetchRequest)) ?? []
        fetchRequest.fetchBatchSize = 50
    }
    
    func saveNews(_ news: News) {
        guard let moc else { return }
        let article = SavedNews(context: moc)
        article.title = news.title
        article.text = news.description
        article.date = news.date
        article.pathForImage = news.pathForImage
        article.id = news.id
        try? moc.save()
    }
    
    func loadNews() -> [News] {
        var newsArray = [News]()
        savedNews.forEach({ article in
            let news = News(title: article.title,
                            description: article.text,
                            date: article.date,
                            pathForImage: article.pathForImage)
            newsArray.append(news)
        })
        return newsArray
    }
}
