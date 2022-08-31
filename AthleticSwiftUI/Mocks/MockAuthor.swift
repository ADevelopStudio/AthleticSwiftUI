//
//  MockAuthor.swift
//  AthleticSwiftUI
//
//  Created by Dmitrii Zverev on 30/8/2022.
//

import Foundation

extension Author {
    static var example: Author {
        let str = #"""
        {
            "deletedAt": null,
            "name": "Chantel Jennings",
            "id": "9FCCA1E1-3391-4842-961C-3C37367DC317",
            "createdAt": "2021-01-20T20:44:43Z",
            "shortname": "C. Jennings",
            "title": "Sr. Writer, Women's Basketball",
            "updatedAt": "2021-01-20T20:44:43Z",
            "imageUrlString": "https:\/\/s3-us-west-2.amazonaws.com\/wp-media-theathletic-production\/app\/uploads\/2017\/08\/28022846\/chantel.png"
        }
        """#
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        guard let data = str.data(using: .utf16),
              let obj = try? decoder.decode(Author.self, from: data) else {
            fatalError()
        }
        return obj
    }
}
