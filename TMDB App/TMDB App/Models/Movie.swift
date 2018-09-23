//
//  Movie.swift
//  TMDB App
//
//  Created by Luciano Bohrer on 22/09/18.
//  Copyright © 2018 Luciano Bohrer. All rights reserved.
//

/*
 
 "vote_count": 1,
 "id": 335983,
 "video": false,
 "vote_average": 0,
 "title": "Venom",
 "popularity": 61.941,
 "poster_path": "/2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg",
 "original_language": "en",
 "original_title": "Venom",
 "genre_ids": [
 27,
 878,
 28,
 53
 ],
 "backdrop_path": "/VuukZLgaCrho2Ar8Scl9HtV3yD.jpg",
 "adult": false,
 "overview": "When Eddie Brock acquires the powers of a symbiote, he will have to release his alter-ego \"Venom\" to save his life.",
 "release_date": "2018-10-03"
 
 */

struct Movie: Codable {
    var id: Int
    var title: String
    var poster_path: String?
    var original_title: String
    var genre_ids: [Int]
    var overview: String
    var release_date: String
}

struct Genre: Codable {
    var id: Int
    var name: String
}
