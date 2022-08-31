//
//  AthleticNetworkModel.swift
//  AthleticSwiftUI
//
//  Created by Dmitrii Zverev on 30/8/2022.
//

import Foundation

final class AthleticNetworkModel {
    enum ServiceError: Error, LocalizedError {
        case generalFailure
        case invalidStatus
        case invalidUrl
        
        public var errorDescription: String? {
            switch self {
            case .invalidStatus:
                return "Nothing found"
            case .generalFailure:
                return "Something went wrong"
            case .invalidUrl:
                return "Invalid Url"
            }
        }
    }
    
    private let baseUrl = URL(string: "https://mobile-interview-backend.theathletic.com/")!

    fileprivate func fetch<T: Decodable>(request: URLRequest) async throws -> T {
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
//        if let dataStr = String(data: data, encoding: .utf8) {
//            print(dataStr)
//        }
        return try decoder.decode(T.self, from: data)
    }
}

extension AthleticNetworkModel {
    
    func fetchFilteringValues(type: ArticleFilterPickerType) async throws -> [Filterable] {
        switch type {
        case .team:
            return try await self.fetchTeams()
        case .league:
            return try await self.fetchLeagues()
        case .author:
            return try await self.fetchAuthors()
        }
    }
    
    func fetchArticles(filter: ArticleFilter = .everything) async throws -> [Article] {
        try await fetch(request: URLRequest(url: baseUrl.appendingPathComponent(filter.apiPath)))
    }
    
    private func fetchTeams() async throws -> [Team] {
        try await fetch(request: URLRequest(url: baseUrl.appendingPathComponent("teams")))
    }
    
    private func fetchLeagues() async throws -> [League] {
        try await fetch(request: URLRequest(url: baseUrl.appendingPathComponent("leagues")))
    }
    
    func fetchAuthors() async throws -> [Author] {
        try await fetch(request: URLRequest(url: baseUrl.appendingPathComponent("authors")))
    }
}
