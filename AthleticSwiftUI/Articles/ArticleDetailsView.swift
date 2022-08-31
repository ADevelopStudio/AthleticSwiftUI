//
//  ArticleDetailsView.swift
//  AthleticSwiftUI
//
//  Created by Dmitrii Zverev on 30/8/2022.
//

import SwiftUI

struct ArticleDetailsView: View {
    @State var article: Article
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                CachedAsyncImage(url: URL(string: article.imageUrlString), transaction: .init(animation: .easeOut)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .scaleEffect(2)
                    case .success(let image):
                        GeometryReader { geo in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geo.size.width, height: 240)
                                .clipped()
                        }
                    case .failure:
                        Image(systemName: "exclamationmark.triangle.fill")
                            .symbolRenderingMode(.multicolor)
                            .resizable()
                            .frame(width: 80, height: 80)
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(height: 240)
                
                Text(article.title)
                    .font(.title2)
                
                Text(article.body)
                    .font(.body)
                
                Spacer()
                
                ForEach(ArticleFilter.generate(from: article)) { filter in
                    NavigationLink {
                        ArticlesView(showFilterButtons: false, preselectedFilter: filter)
                    } label: {
                        Text(filter.buttonTitle)
                    }
                    .padding(.vertical, 5)
                }
            }
            .padding(.horizontal)
        }
    }
}
