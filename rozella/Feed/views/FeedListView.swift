//
//  FeedListView.swift
//  rozella
//
//  Created by SHOHJAHON on 25/03/24.
//

import SwiftUI

struct FeedListView: View {
    @State private var feeds: [RSSFeed] = []
    @State private var showAddFeedSheet = false // State for the add feed sheet
    @State private var disclosureGroupLabel = "RSS Feeds"
    var body: some View {
        NavigationStack {
            List {
                DisclosureGroup {
                        ForEach(feeds) { feed in
                            NavigationLink(destination: ArticleView(feed: feed)) {
                                Text(feed.title)
                            }
                        }
                        .onDelete(perform: removeFeeds)
                    
                }            label: {
                    HStack {
                      Text(disclosureGroupLabel)
                      Spacer()
                      Image(systemName: "folder")
                    }
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
            .onAppear {
                feeds = RSSFeed.loadFeeds()// Load feeds on view appearance
            }
            .onChange(of: feeds) {_, newFeeds in
                RSSFeed.saveFeed(feeds: newFeeds)
        }
        }
        
    }
    
    
    func removeFeeds(at offsets: IndexSet) {
        feeds.remove(atOffsets: offsets)
        RSSFeed.saveFeed(feeds: [])
    }
}


#Preview {
    FeedListView()
}
