
import Foundation

struct RSSFeed: Identifiable, Codable {
    let id = UUID()
    let title: String
    let url: URL
}
