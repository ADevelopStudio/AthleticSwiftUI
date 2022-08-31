//
//  ArticleListView.swift
//  AthleticSwiftUI
//
//  Created by Dmitrii Zverev on 30/8/2022.
//

import SwiftUI

struct ArticleListElementView: View {
    @State var article: Article
    
    var body: some View {
        ZStack {
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
            Color(white: 0, opacity: 0.65)
            VStack {
                Spacer()
                HStack {
                    Text(article.title)
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                    Spacer()
                }
            }
            .padding()
        }
        .frame(height: 240)
    }
}

struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ArticleListElementView(article: .example)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
        }
    }
}
