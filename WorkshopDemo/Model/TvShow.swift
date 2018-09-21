//
//  TVShow.swift
//  WorkshopDemo
//
//  Created by Hrvoje Stanisic on 20.09.18.
//  Copyright © 2018 WomenInTech. All rights reserved.
//

import Foundation

struct TvShow: Codable {
    var id: Int64
    var name: String
    var overview: String
    var poster: String?
    var thumbnail: String?
    var rating: Double

    private enum CodingKeys: String, CodingKey {
        case id, name, overview, poster = "poster_path", thumbnail = "backdrop_path", rating = "vote_average"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        poster = TvShow.fullUrl(for: try? container.decode(String.self, forKey: .poster))
        thumbnail = TvShow.fullUrl(for: try? container.decode(String.self, forKey: .thumbnail))
        id = try container.decode(Int64.self, forKey: .id)
        overview = try container.decode(String.self, forKey: .overview)
        name = try container.decode(String.self, forKey: .name)
        rating = try container.decode(Double.self, forKey: .rating)
    }

    private static func fullUrl(for path: String?) -> String? {
        guard let path = path else { return nil}
        return "https://image.tmdb.org/t/p/w500/\(path)"
    }
}

final class TvShowResult: Codable {
    var items: [TvShow] = []

    private enum CodingKeys: String, CodingKey {
        case items = "results"
    }
}
