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
    
    private(set) var articleFilter: ArticleFilter = .everything
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
        self.articleFilter = articleFilter
        await self.fetchArticles()
    }
    
    func fetchArticles() async {
        loadingState = .loading
        do {
            let result = try await network.fetchArticles(filter: self.articleFilter)
            loadingState = .loaded(result)
        } catch {
            loadingState = .failedToUpdate(error.localizedDescription)
        }
    }
}
