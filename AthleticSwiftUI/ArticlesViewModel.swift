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

    private let network = AthleticNetworkModel()

    init() { }
    
    func fetchArticles() async {
        loadingState = .loading
        do {
            let result = try await network.fetchArticles()
            loadingState = .loaded(result)
        } catch {
            loadingState = .failedToUpdate(error.localizedDescription)
        }
    }
}
