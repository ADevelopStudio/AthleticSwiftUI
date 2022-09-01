//
//  MockArticle.swift
//  AthleticSwiftUI
//
//  Created by Dmitrii Zverev on 30/8/2022.
//

import Foundation

extension Article {
    static var example: Article {
        let str = #"""
        {
            "imageUrlString": "https:\/\/cdn.theathletic.com\/app\/uploads\/2020\/12\/23091504\/GettyImages-1230267328-1024x683.jpg",
            "deletedAt": null,
            "author": {
                "id": "A38A908F-DBEB-4CDC-980B-7C5EB5F4B8D0"
            },
            "title": "Andrew Wiggins’ bad night and what role with the Warriors is best for him",
            "team": {
                "id": "1D77739F-CF57-4235-B901-9BC17ECD65B7"
            },
            "id": "FF1F32E5-7D36-4AC7-B855-3BBD5907ADF6",
            "updatedAt": "2021-01-20T20:44:58Z",
            "createdAt": "2021-01-20T20:44:58Z",
            "body": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In pharetra id mi ultricies aliquam. Donec feugiat magna nulla, nec accumsan leo blandit dictum. Vestibulum mattis consequat elit at tempor. Duis ornare porttitor ultricies. Ut nunc dolor, pretium in justo eget, gravida pharetra neque. Fusce quis quam risus. Pellentesque a interdum nisl, et facilisis mauris. Etiam sit amet facilisis nibh.\n\nProin sollicitudin orci ultricies nibh maximus, vel faucibus arcu egestas. Sed at tortor non dolor condimentum volutpat accumsan eget justo. Cras in ornare felis, sagittis posuere quam. Vestibulum congue convallis diam sit amet iaculis. Maecenas eleifend nibh dolor. Morbi erat lorem, elementum eget dolor ac, volutpat vulputate libero. Nam non justo a erat cursus sodales vitae ac augue. Sed facilisis, lacus eu interdum aliquam, orci sapien lacinia tortor, id ullamcorper odio nisl vitae eros. Integer quam sem, venenatis luctus ligula non, mattis finibus velit. Duis eget dapibus quam, vel viverra purus. Aenean egestas nunc maximus odio viverra pulvinar. Phasellus ex eros, condimentum ut pulvinar quis, pretium non elit. Phasellus et est quis est finibus cursus.\n\nUt quis lobortis ligula. Nulla fermentum placerat lacus at varius. Duis maximus nisi ut est dapibus accumsan. Etiam vel pretium diam, nec aliquet ipsum. Proin nec aliquam urna. Maecenas bibendum tristique finibus. Nam tempus tempus mi in pharetra. Aenean leo dolor, sodales in neque id, commodo tincidunt dui. Nam et rutrum diam, quis volutpat mi. Maecenas accumsan hendrerit malesuada. Quisque laoreet mauris lorem, quis dignissim nisl pharetra sit amet.\n\nClass aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Duis mollis elementum mauris in tempus. Donec sed ullamcorper magna, eget pretium lorem. Fusce placerat facilisis mi, ut dictum magna mattis ac. Integer nunc ipsum, feugiat eget egestas finibus, ultrices at felis. Donec ut orci quis quam feugiat rutrum. Curabitur efficitur enim purus, eu vulputate nisl lobortis non. Praesent vulputate massa eget tortor fermentum elementum. Aenean ullamcorper ante eu felis dapibus, vel varius tortor gravida. Quisque commodo, elit vel ornare facilisis, ligula justo porta erat, sed scelerisque justo sapien fermentum eros. Proin lacus purus, tincidunt non faucibus quis, pretium efficitur metus. Etiam nec libero congue, consequat ipsum et, fringilla purus. Pellentesque id justo eu arcu posuere lacinia.\n\nPraesent eget tortor fermentum, interdum urna gravida, porta ex. Donec laoreet turpis neque, non condimentum enim aliquam eu. Vivamus quis justo et quam consectetur mattis. Morbi ut ullamcorper nulla. Donec eget massa non lectus vulputate mattis ac sit amet nibh. Praesent laoreet ligula ut posuere suscipit. Nulla molestie est neque, vitae bibendum arcu fermentum eu. Morbi fringilla orci augue, in pulvinar diam bibendum sit amet. Praesent ullamcorper pellentesque facilisis. Donec cursus dignissim vehicula. Nam quis commodo leo. Phasellus semper lacus vitae imperdiet tristique. Fusce egestas lacus ac euismod condimentum. Mauris venenatis ultrices ultrices. Donec venenatis nunc eget urna commodo vulputate. Donec id dolor ullamcorper, pellentesque libero sed, commodo enim.\n\nMorbi eget augue non est tincidunt mollis a vitae tellus. Aenean ac erat pellentesque ligula dapibus ornare. Donec enim eros, iaculis eget diam id, vehicula aliquet metus. Etiam vitae accumsan lorem. Ut eget pretium magna. Curabitur pretium, nisl et ultrices scelerisque, libero purus posuere mi, eu laoreet neque neque at enim. Donec commodo neque quis erat aliquam accumsan eget id orci. Praesent laoreet lectus vel nibh feugiat, id gravida orci efficitur. Nullam erat nibh, hendrerit eget interdum et, condimentum eget mauris. Nunc laoreet sodales ipsum, vitae aliquet est auctor vitae.\n\nPraesent vel magna vitae turpis facilisis pulvinar. Aliquam eget fermentum ipsum. Vestibulum eleifend nisl quam, vel sagittis nunc tincidunt id. Proin at volutpat quam. Sed eu sapien in nisl iaculis tincidunt. Maecenas pharetra nulla sed ex facilisis viverra. Suspendisse aliquam, quam vel fringilla lacinia, tortor enim scelerisque risus, sed elementum odio sem sed diam. Morbi tempus odio nec lacus ornare, et efficitur dolor interdum.",
            "league": {
                "id": "8D59D789-49A3-43F0-86B5-23166ACBDC15"
            }
        }
        """#
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        guard let data = str.data(using: .utf16),
              let obj = try? decoder.decode(Article.self, from: data) else {
            fatalError()
        }
        return obj
    }
}
