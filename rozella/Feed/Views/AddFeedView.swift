//
//  AddFeedView.swift
//  rozella
//
//  Created by SHOHJAHON on 25/03/24.
//

import SwiftUI

struct AddFeedView: View {
    @Binding var feeds: [RSSFeed] // Binding to update the main feeds array
    @State private var newFeedTitle = ""
    @State private var newFeedURL = ""

    @Environment(\.dismiss) var dismiss // To dismiss the sheet

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $newFeedTitle)
                TextField("URL", text: $newFeedURL)
                    .keyboardType(.URL) // Set keyboard for URL input
                    .autocapitalization(.none) // Disable auto-capitalization
           
                
                Button("Add Feed") {
                    if let url = URL(string: newFeedURL) {
                        let newFeed = RSSFeed(title: newFeedTitle, url: url)
                        feeds.append(newFeed)
                        dismiss() // Close the sheet
                    } else {
                        // Handle invalid URL (e.g., show an error message to the user)
                    }
                }
                }
            }
            .navigationTitle("Add New Feed")
        }
    }

//#Preview {
//    AddFeedView()
//}
