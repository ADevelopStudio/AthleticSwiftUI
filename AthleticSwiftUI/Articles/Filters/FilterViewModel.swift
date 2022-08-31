//
//  FilterViewModel.swift
//  AthleticSwiftUI
//
//  Created by Dmitrii Zverev on 31/8/2022.
//

import Foundation

@MainActor
class FilterViewModel: ObservableObject {
    enum LoadingState {
        case loaded([Filterable])
        case loading
        case failedToUpdate(String)
    }
    @Published private(set) var loadingState = LoadingState.loading
    
    private let network = AthleticNetworkModel()
    
    func fetchResults(type: ArticleFilterPickerType) async {
        loadingState = .loading
        do {
            let result = try await network.fetchFilteringValues(type: type)
            loadingState = .loaded(result)
        } catch {
            loadingState = .failedToUpdate(error.localizedDescription)
        }
    }
}
