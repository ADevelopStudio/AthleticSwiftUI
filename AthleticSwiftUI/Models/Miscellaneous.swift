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

enum ArticleFilter: Comparable, Identifiable {
    case everything
    case byAuthor(id: String)
    case byTeam(id: String)
    case byLeague(id: String)
    
    var id: String { String(describing: self) }
}

extension ArticleFilter {
    var buttonTitle: String {
        switch self {
        case .everything:
            return "Show all articles"
        case .byAuthor:
            return "Show all articles of this author"
        case .byTeam:
            return "Show all articles about this team"
        case .byLeague:
            return "Show all articles about this league"
        }
    }
    
    static func generate(from article: Article) ->  [ArticleFilter] {
        [
            .byTeam(id: article.team.id),
            .byLeague(id: article.league.id),
            .byAuthor(id: article.author.id),
        ]
    }
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
