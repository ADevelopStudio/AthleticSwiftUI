//
//  Miscellaneous.swift
//  AthleticSwiftUI
//
//  Created by Dmitrii Zverev on 31/8/2022.
//

import Foundation

protocol Filterable: Codable {
    var id: String { get }
    var name: String { get }
}


struct IdentifiableObject: Codable{
    var id: String
}

enum ArticleFilterPickerType: CaseIterable, Identifiable {
    case team
    case league
    case author
    var id: ArticleFilterPickerType {self}
}

extension ArticleFilterPickerType {
    var buttonTitle: String {
        ["By", String(describing: self)].joined(separator: " ")
    }
}

enum ArticleFilter: Comparable {
    case everything
    case byAuthor(id: String)
    case byTeam(id: String)
    case byLeague(id: String)
}

extension ArticleFilter{
    var apiPath: String {
        switch self {
        case .everything:
            return "articles"
        case .byAuthor(let id):
            return "authors/\(id)/articles"
        case .byTeam(let id):
            return "teams/\(id)/articles"
        case .byLeague(let id):
            return "leagues/\(id)/articles"
        }
    }
}
