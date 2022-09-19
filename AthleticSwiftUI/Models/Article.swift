//
//  Article.swift
//  AthleticSwiftUI
//
//  Created by Dmitrii Zverev on 30/8/2022.
//

import Foundation

struct Article: Codable, Identifiable{
    let id: String
    let title: String
    let imageUrlString: String
    let body: String
    private let createdAt: Date
    private let updatedAt: Date
    private let deletedAt: Date?
    
    let league: IdentifiableObject
    let team: IdentifiableObject
    let author: IdentifiableObject
    
    lazy var publishedDate: String = {
        let df = DateFormatter()
        df.dateStyle = .full
        df.timeStyle = .medium
        df.doesRelativeDateFormatting = true
        if  df.string(from: createdAt) == df.string(from: updatedAt) {
            return df.string(from: createdAt)
        } else {
            return ["Posted:",
                    df.string(from: createdAt),"\nUpdated:",
                    df.string(from: updatedAt)
            ].joined(separator: " ")
        }
    }()
}
