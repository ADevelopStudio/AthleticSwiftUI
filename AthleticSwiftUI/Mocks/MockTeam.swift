//
//  MockTeam.swift
//  AthleticSwiftUI
//
//  Created by Dmitrii Zverev on 30/8/2022.
//

import Foundation

extension Team {
    static var example: Team {
        let str = #"""
        {
            "league": {
                "id": "54E5D383-2D99-45D2-804A-C9DF69B877A7"
            },
            "id": "9C08C9CC-56FF-4FE3-AF7E-255FF3C62161",
            "shortname": "BAY",
            "updatedAt": "2021-01-20T20:44:43Z",
            "name": "Bayern Munich",
            "deletedAt": null,
            "createdAt": "2021-01-20T20:44:43Z"
        }
        """#
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        guard let data = str.data(using: .utf16),
              let obj = try? decoder.decode(Team.self, from: data) else {
            fatalError()
        }
        return obj
    }
}
