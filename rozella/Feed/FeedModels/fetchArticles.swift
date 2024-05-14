import FeedKit
import Foundation
import SwiftSoup
import OSLog

func fetchArticles(from feed: RSSFeed, completion: @escaping ([Article]) -> Void) {
    
    let parser = FeedParser(URL: feed.url)
    
    parser.parseAsync { result in
        
        switch result {
            
        case .success(let feed):
            
            let articles: [Article] = feed.rssFeed?.items?.map { item in
                Article(
                    link: URL(string: item.link ?? "http://[::]")!,
                    title: item.title ?? "",
                    description: item.description ?? "",
                    contentEncoded: item.content?.contentEncoded,
                    image: RSSFeedImage()
                )
            } ?? []
            
            completion(articles)
            
        case .failure(let error):
            print(error)
            completion([])
        }
    }
}

