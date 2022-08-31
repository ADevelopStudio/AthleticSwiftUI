//
//  ArticlesView.swift
//  AthleticSwiftUI
//
//  Created by Dmitrii Zverev on 30/8/2022.
//

import SwiftUI

struct ArticlesView: View {
    @StateObject fileprivate var viewModel =  ArticlesViewModel()
    @State private var showingPickFilterValueModal = false
    
    @State var showFilterButtons: Bool
    @State var preselectedFilter: ArticleFilter
    
    var body: some View {
        NavigationView {
            switch viewModel.loadingState {
            case .loaded(let articles):
                if articles.isEmpty {
                    VStack(spacing: 15) {
                        Image(systemName: "doc.text.magnifyingglass")
                            .symbolRenderingMode(.multicolor)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 80)
                        Text("No articles found")
                            .font(.title2)
                        Button("Reset") {
                            Task { await self.viewModel.changeFilter(to: .everything) }
                        }
                    }
                } else {
                    VStack {
                        if showFilterButtons {
                            ArticlesFilterPanelView(selectedFilterType: $viewModel.selectedFilterType, showingPickFilterValueModal: $showingPickFilterValueModal, needToShowReset: viewModel.needToShowResetFilterButton) {
                                Task { await self.viewModel.changeFilter(to: .everything) }
                            }
                        }
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
                    .navigationTitle("Articles")
                }
            case .failedToUpdate(let error):
                VStack(spacing: 15) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .symbolRenderingMode(.multicolor)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
                    Text(error)
                        .font(.headline)
                    Button("Try again") {
                        Task {
                            await self.viewModel.fetchArticles()
                        }
                    }
                }
            case .loading:
                ProgressView()
                    .scaleEffect(2)
            }
        }
        .sheet(isPresented: $showingPickFilterValueModal) {
            FilterView(type: viewModel.selectedFilterType, isPresented: $showingPickFilterValueModal, selectedFilter: $viewModel.selectedFilter)
        }
        .task {
            await self.viewModel.changeFilter(to: self.preselectedFilter)
        }
    }
}

struct ArticlesView_Previews: PreviewProvider {
    static var previews: some View {
//        NavigationView {
            ArticlesView(showFilterButtons: true, preselectedFilter: .everything)
//        }
    }
}
