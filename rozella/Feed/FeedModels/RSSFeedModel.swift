
import Foundation

struct RSSFeed: Identifiable, Codable, Equatable {
    var id = UUID()
    let title: String
    let url: URL
    
    
    static  func saveFeed(feeds: [RSSFeed]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(feeds) {
            UserDefaults.standard.set(encoded, forKey: "savedFeeds")
        }
    }
    
    
   static func loadFeeds() -> [RSSFeed] {
        if let savedData = UserDefaults.standard.data(forKey: "savedFeeds") {
            let decoder = JSONDecoder()
            if let savedFeeds = try? decoder.decode([RSSFeed].self, from: savedData) {
                return savedFeeds
            }
        }
        return []
    }
}


