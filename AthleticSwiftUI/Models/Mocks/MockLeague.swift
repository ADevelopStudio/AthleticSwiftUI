//
//  MockLeague.swift
//  AthleticSwiftUI
//
//  Created by Dmitrii Zverev on 1/9/2022.
//

import Foundation

extension League {
    static var example: League {
        let str = #"""
        {
            "deletedAt": null,
            "createdAt": "2021-01-20T20:44:43Z",
            "title": "Boxing",
            "name": "Boxing",
            "id": "013EE947-D533-4BD0-82BE-602F6C2DB264",
            "updatedAt": "2021-01-20T20:44:43Z",
            "sportType": "boxing",
            "shortName": "BOX"
        }
        """#
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        guard let data = str.data(using: .utf16),
              let obj = try? decoder.decode(League.self, from: data) else {
            fatalError()
        }
        return obj
    }
}
