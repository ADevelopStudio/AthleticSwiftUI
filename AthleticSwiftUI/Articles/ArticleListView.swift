//
//  ArticleListView.swift
//  AthleticSwiftUI
//
//  Created by Dmitrii Zverev on 31/8/2022.
//

import SwiftUI

struct ArticleListView: View {
    @State var articles: [Article]
    
    var body: some View {
        List(articles) { article in
            ZStack {
                NavigationLink {
                    ArticleDetailsView(article: article)
                } label: {
                    EmptyView()
                }
                ArticleListElementView(article: article)
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
            
        }
        .listStyle(.grouped)
        .padding(.horizontal, -20)
    }
}

struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ArticleListView(articles: [.example])
        }
    }
}
