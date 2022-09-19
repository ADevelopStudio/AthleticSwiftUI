//
//  ArticlesViewModel.swift
//  AthleticSwiftUI
//
//  Created by Dmitrii Zverev on 30/8/2022.
//

import Foundation
import SwiftUI

@MainActor
class ArticlesViewModel: ObservableObject {
    enum LoadingState {
        case loaded
        case loading
        case failedToUpdate(String)
    }
    
    @Published private(set) var loadingState = LoadingState.loading
    
    @Published var searchText = "" {
        didSet {
            searchTimer?.invalidate()
            searchTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { _ in
                Task { await self.performSearch() }
            })
        }
    }
    
    @Published var filteredArticles: [Article] = []
    private var articles: [Article] = []
    private var searchTimer: Timer?
    
    
    private let network = AthleticNetworkModel()
    
    var selectedFilterType: ArticleFilterPickerType = .league
    var needToShowResetFilterButton: Bool {
        self.selectedFilter != .everything
    }
    
    @Published var selectedFilter: ArticleFilter? {
        didSet {
            if let selectedFilter = selectedFilter, selectedFilter != oldValue {
                Task {
                    await self.fetchArticles()
                }
            }
        }
    }
    
    func fetchArticles() async {
        guard let articleFilter = selectedFilter else {
            loadingState = .failedToUpdate("Filter was not set")
            return
        }
        filteredArticles = []
        articles = []
        searchText = ""
        loadingState = .loading
        do {
            let result = try await network.fetchArticles(filter: articleFilter)
            self.articles = result
            self.performSearch()
            loadingState = .loaded
        } catch {
            loadingState = .failedToUpdate(error.localizedDescription)
        }
    }
    
    private func performSearch() {
        if searchText.count < 3 {
            filteredArticles = articles
        } else {
            filteredArticles = articles.filter({$0.title.lowercased().contains(searchText.lowercased())})
        }
    }
}
