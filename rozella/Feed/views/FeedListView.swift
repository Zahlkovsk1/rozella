//
//  FeedListView.swift
//  rozella
//
//  Created by SHOHJAHON on 25/03/24.
//

import SwiftUI

import SwiftUI

struct FeedListView: View {
    @State private var feeds: [RSSFeed] = []
    @State private var showAddFeedSheet = false // State for the add feed sheet

    var body: some View {
        NavigationView { // Embed in a NavigationView for navigation structure
            List(feeds) { feed in
                NavigationLink(destination: ArticleView(feed: feed)) {
                    Text(feed.title)
                }
            }
            .navigationTitle("RSS Feeds")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddFeedSheet = true // Show the sheet to add feeds
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddFeedSheet) {
                AddFeedView(feeds: $feeds) // Pass the feeds array by reference
            }
        }
        .onAppear {
            feeds = RSSFeed.loadFeeds()// Load feeds on view appearance
        }
        .onChange(of: feeds) {_, newFeeds in
            RSSFeed.saveFeed(feeds: newFeeds)
        }
    }
//
//    // Function to load initial feeds
//    private func loadInitialFeeds() {
//        if let savedFeedsData = UserDefaults.standard.data(forKey: "savedFeeds") {
//            let decoder = JSONDecoder()
//            if let savedFeeds = try? decoder.decode([RSSFeed].self, from: savedFeedsData) {
//                feeds = savedFeeds
//            }
//        } else {
//            // Load some default feeds if there's no saved data
//            feeds = [
//                RSSFeed(title: "Example Feed 1", url: URL(string: "https://example.com/feed.rss")!),
//                // ... Add more default feeds if needed ...
//            ]
//        }
//    }
//    
//    private func saveFeeds() {
//        let encoder = JSONEncoder()
//        if let encodedFeeds = try? encoder.encode(feeds) {
//            UserDefaults.standard.set(encodedFeeds, forKey: "savedFeeds")
//        }
//    }
    
}


#Preview {
    FeedListView()
}
