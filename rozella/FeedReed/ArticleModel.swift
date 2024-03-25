
import Foundation

struct Article: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let link: URL
    var scrapedContent: String? // For storing scraped text
}
