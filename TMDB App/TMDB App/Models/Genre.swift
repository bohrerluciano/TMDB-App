//
//  Genre.swift
//  TMDB App
//
//  Created by Luciano Bohrer on 23/09/18.
//  Copyright © 2018 Luciano Bohrer. All rights reserved.
//

import Foundation

// MARK: Genre
struct Genre: Codable {
    var id: Int
    var name: String
}

// MARK: Static methods
extension Genre {
    
    static func genresNames(ids: [Int]) -> [Genre] {
        
            if  let file = Bundle.main.url(forResource: "genres", withExtension: "json"),
                let data = try? Data(contentsOf: file),
                let dict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                
                if  let dictGenres = dict,
                    let items = dictGenres["genres"],
                    let data = try? JSONSerialization.data(withJSONObject: items, options: .prettyPrinted) {
                    let decoder = JSONDecoder()
                    let genres = try? decoder.decode([Genre].self, from: data)
                    
                    return genres?.filter({ ids.contains($0.id) }) ?? []
                }
                
        }
        return []
    }
}
