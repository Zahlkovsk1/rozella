//
//  AddFeedView.swift
//  rozella
//
//  Created by SHOHJAHON on 25/03/24.
//

import SwiftUI

struct AddFeedView: View {
    @Binding var feeds: [RSSFeed] 
    @State private var newFeedTitle = ""
    @State private var newFeedURL = ""

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $newFeedTitle)
                TextField("URL", text: $newFeedURL)
                    .keyboardType(.URL)
                    .autocapitalization(.none)
           
                
                Button("Add Feed") {
                    if let url = URL(string: newFeedURL) {
                        let newFeed = RSSFeed(title: newFeedTitle, url: url)
                        feeds.append(newFeed)
                        dismiss()
                    } else {
                        
                    }
                }
                }
            }
            .navigationTitle("Add New Feed")
        }
    }


