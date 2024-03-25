import FeedKit
import Foundation

func fetchArticles(from feed: RSSFeed, completion: @escaping ([Article]) -> Void) {
    let parser = FeedParser(URL: feed.url)
    parser.parseAsync { result in
        switch result {
        case .success(let feed):
            let articles = feed.rssFeed?.items?.map { item in
                Article(title: item.title ?? "",
                        description: item.description ?? "",
                        link: URL(string: item.link ?? "https://example.com") ?? URL(string: "https://example.com")!,
                        scrapedContent: nil) // Initializing with nil
            } ?? []
            completion(articles)
        case .failure(let error):
            print(error)
            completion([])
        }
    }
}

