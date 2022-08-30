//
//  AthleticNetworkModel.swift
//  AthleticSwiftUI
//
//  Created by Dmitrii Zverev on 30/8/2022.
//

import Foundation
/*
extension ApiPath {
    private static let apiKey = "95d190a434083879a6398aafd54d9e73"
    
    private var queryItem: URLQueryItem {
        switch self {
        case .search(let searchString):
            return URLQueryItem(name: "q", value: [searchString, "au"].joined(separator: ","))
        case .update(let id):
            return URLQueryItem(name: "id", value: String(describing: id))
        }
    }
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = "/data/2.5/weather"
        let queryAppId = URLQueryItem(name: "appid", value: ApiPath.apiKey)
        let queryMetric = URLQueryItem(name: "units", value: "metric")
        components.queryItems = [self.queryItem, queryAppId, queryMetric]
        return components.url
    }
}
 */

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

    func fetchArticles() async throws -> [Article] {
        try await fetch(request: URLRequest(url: baseUrl.appendingPathComponent("articles")))
    }

    private func fetch<T: Decodable>(request: URLRequest) async throws -> T {
        let (data, _) = try await URLSession.shared.data(for: request)

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        if let dataStr = String(data: data, encoding: .utf8) {
            print(dataStr)
        }
        return try decoder.decode(T.self, from: data)
    }
}
