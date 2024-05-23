

import SwiftUI

struct FeedListView: View {
    @State private var feeds: [RSSFeed] = []
    @State private var showAddFeedSheet = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(feeds) { feed in
                    NavigationLink(destination: ArticleView(feed: feed)) {
                        Text(feed.title)
                    }
                }
                .onDelete(perform: removeFeeds)
            }
            .navigationTitle("RSS Feeds")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddFeedSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddFeedSheet) {
                AddFeedView(feeds: $feeds)
            }
            .task(priority: .high) {
                loadFeeds()
            }
            .onChange(of: feeds) { _, newFeeds in
                RSSFeed.saveFeed(feeds: newFeeds)
            }
        }
    }
    
    func removeFeeds(at offsets: IndexSet) {
        feeds.remove(atOffsets: offsets)
        RSSFeed.saveFeed(feeds: feeds) // Save the updated list of feeds
    }
    
    func loadFeeds() {
        // Load feeds from storage
        feeds = RSSFeed.loadFeeds()
        
       
        if feeds.isEmpty {
            let defaultFeeds = [
                RSSFeed(title: "Feed 1", url: URL(string: "https://www.developeracademy.unina.it/en/feed/")!),
                RSSFeed(title: "Feed 2", url: URL(string: "https://googleprojectzero.blogspot.com/feeds/posts/default?alt=rss")!)
            ]
            feeds = defaultFeeds
            RSSFeed.saveFeed(feeds: defaultFeeds)
        }
    }
}

#Preview {
    FeedListView()
}
