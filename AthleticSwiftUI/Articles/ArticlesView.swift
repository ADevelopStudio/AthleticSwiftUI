//
//  ArticlesView.swift
//  AthleticSwiftUI
//
//  Created by Dmitrii Zverev on 30/8/2022.
//

import SwiftUI

struct ArticlesView: View {
    @StateObject fileprivate var viewModel = ArticlesViewModel()
    @State private var showingPickFilterValueModal = false
    
    @State var showFilterButtons: Bool
    @State var preselectedFilter: ArticleFilter
    
    var body: some View {
        VStack {
            switch viewModel.loadingState {
            case .loaded:
                if viewModel.filteredArticles.isEmpty {
                    VStack(spacing: 15) {
                        Image(systemName: "doc.text.magnifyingglass")
                            .symbolRenderingMode(.multicolor)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 80)
                        Text("No articles found")
                            .font(.title2)
                        Button("Reset") {
                            self.viewModel.selectedFilter = .everything
                        }
                    }
                } else {
                    VStack {
                        if showFilterButtons {
                            ArticlesFilterPanelView(selectedFilterType: $viewModel.selectedFilterType, showingPickFilterValueModal: $showingPickFilterValueModal, needToShowReset: viewModel.needToShowResetFilterButton) {
                                self.viewModel.selectedFilter = .everything
                            }
                        }
                        ArticleListView(articles: $viewModel.filteredArticles)
                    }
                    .searchable(text: $viewModel.searchText)
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
                        self.viewModel.selectedFilter = .everything
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
            self.viewModel.selectedFilter = self.preselectedFilter
        }
    }
}

struct ArticlesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ArticlesView(showFilterButtons: true, preselectedFilter: .everything)
        }
    }
}
