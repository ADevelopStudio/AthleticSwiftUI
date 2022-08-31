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
    let createdAt: Date
    let updatedAt: Date
    let deletedAt: Date?
    
    let league: IdentifiableObject
    let team: IdentifiableObject
    let author: IdentifiableObject
}