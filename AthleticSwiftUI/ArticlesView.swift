//
//  ArticlesView.swift
//  AthleticSwiftUI
//
//  Created by Dmitrii Zverev on 30/8/2022.
//

import SwiftUI

struct ArticlesView: View {
    @StateObject fileprivate var viewModel = ArticlesViewModel()
    
    var body: some View {
        NavigationView {
            switch viewModel.loadingState {
            case .loaded(let articles):
                List(articles) { article in
                    ZStack {
                        NavigationLink {
                            ArticleDetailsView(article: article)
                        } label: {
                            EmptyView()
                        }
                        ArticleListView(article: article)
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
                    
                }
                .listStyle(.grouped)
                .padding(.horizontal, -20)
                .navigationTitle("Articles")
            case .failedToUpdate(let error):
                VStack(spacing: 15) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .symbolRenderingMode(.multicolor)
                        .resizable()
                        .frame(width: 80, height: 80)
                    Text(error)
                        .font(.title2)
                }
            case .loading:
                ProgressView()
                    .scaleEffect(2)
            }
        }
        .task {
            await viewModel.fetchArticles()
        }
    }
}

struct ArticlesView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesView()
    }
}
