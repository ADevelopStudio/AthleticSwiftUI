//
//  ArticlesViewModel.swift
//  AthleticSwiftUI
//
//  Created by Dmitrii Zverev on 30/8/2022.
//

import Foundation

@MainActor
class ArticlesViewModel: ObservableObject {
    enum LoadingState {
        case loaded([Article])
        case loading
        case failedToUpdate(String)
    }
    
    @Published private(set) var loadingState = LoadingState.loading
    
    private var articleFilter: ArticleFilter? = nil
    private let network = AthleticNetworkModel()
    
    
    var selectedFilterType: ArticleFilterPickerType = .league
    
    var needToShowResetFilterButton: Bool {
        self.articleFilter != .everything
    }
    
    var selectedFilter: ArticleFilter? {
        didSet {
            if let selectedFilter = selectedFilter {
                Task { await self.changeFilter(to: selectedFilter) }
            }
        }
    }
    
    func changeFilter(to articleFilter: ArticleFilter) async {
        if self.articleFilter == articleFilter { return }
        self.articleFilter = articleFilter
        await self.fetchArticles()
    }
    
    func fetchArticles() async {
        guard let articleFilter = articleFilter else {
            loadingState = .failedToUpdate("Filter was not set")
            return
        }
        loadingState = .loading
        do {
            let result = try await network.fetchArticles(filter: articleFilter)
            loadingState = .loaded(result)
        } catch {
            loadingState = .failedToUpdate(error.localizedDescription)
        }
    }
}
