//
//  SummaryView.swift
//  rozella
//
//  Created by SHOHJAHON on 19/05/24.
//

import SwiftUI

struct SummaryView: View {
    let summary: String
    
    var body: some View {
        VStack {
            Text("Summary")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            ScrollView(.vertical) {
                Text(summary)
                    .padding()
            }
        }
        .padding()
    }
}

#Preview {
    SummaryView(summary: "")
}
