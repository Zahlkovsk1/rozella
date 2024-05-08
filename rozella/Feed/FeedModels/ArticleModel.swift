
import SwiftUI
import FeedKit

struct Article: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    var link: URL
    var scrapedContent: String?
    var image: RSSFeedImage
}
