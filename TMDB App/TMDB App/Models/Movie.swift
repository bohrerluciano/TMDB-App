//
//  Movie.swift
//  TMDB App
//
//  Created by Luciano Bohrer on 22/09/18.
//  Copyright © 2018 Luciano Bohrer. All rights reserved.
//

import Foundation

// MARK: - Struct
struct Movie: Codable {
    
    // MARK: Internal variables
    var id: Int
    var title: String
    var poster_path: String?
    var original_title: String
    var overview: String
    var release_date: String
    var genre_ids: [Int]
    var formattedData: String {
        get {
            let fromDate = DateFormatter()
            fromDate.dateFormat = "yyyy-MM-dd"
            let toDate = DateFormatter()
            toDate.dateFormat = "dd\nMMM"
            
            if let date = fromDate.date(from: self.release_date) {
                return toDate.string(from: date)
            }
            return ""
        }
    }
}
