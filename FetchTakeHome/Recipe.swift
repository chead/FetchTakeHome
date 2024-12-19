//
//  Recipe.swift
//  FetchTakeHome
//
//  Created by Christopher Head on 12/18/24.
//

import Foundation

struct Recipe: Decodable, Identifiable {
    let cuisine: String
    let name: String
    let photoURL: String
    let thumbnailURL: String
    let id: UUID
    let sourceURL: URL?
    let youtubeURL: URL?

    enum CodingKeys: CodingKey {
        case cuisine
        case name
        case photo_url_large
        case photo_url_small
        case uuid
        case source_url
        case youtube_url
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.cuisine = try container.decode(String.self, forKey: .cuisine)
        self.name = try container.decode(String.self, forKey: .name)
        self.photoURL = try container.decode(String.self, forKey: .photo_url_large)
        self.thumbnailURL = try container.decode(String.self, forKey: .photo_url_small)
        self.id = try container.decode(UUID.self, forKey: .uuid)
        self.sourceURL = try container.decodeIfPresent(URL.self, forKey: .source_url)
        self.youtubeURL = try container.decodeIfPresent(URL.self, forKey: .youtube_url)
    }
}
