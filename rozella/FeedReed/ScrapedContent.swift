//
//  ScrapedContent.swift
//  rozella
//
//  Created by SHOHJAHON on 25/03/24.
//

import SwiftUI
import SwiftSoup


func scrapeContent(from article: Article, completion: @escaping (Article) -> Void) {
    guard article.link != nil else { return }

    do {
        let html = try String(contentsOf: article.link)
        let doc = try SwiftSoup.parse(html)

        // Replace with your specific scraping logic:
        let content = try doc.select("div.article-body").text()

        var updatedArticle = article
        updatedArticle.scrapedContent = content
        completion(updatedArticle)
    } catch {
        print(error)
    }
}
