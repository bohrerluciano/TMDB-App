//
//  TMDBApi.swift
//  TMDB App
//
//  Created by Luciano Bohrer on 22/09/18.
//  Copyright © 2018 Luciano Bohrer. All rights reserved.
//

import RxSwift
import Alamofire
import Nuke

// MARK: - Class
final class TMDBApi {
    
    // MARK: Definitions
    enum Error: Swift.Error {
        case generic
    }
    
    struct Endpoint {
        static let getGenres = "/genre/movie/list"
        static let getUpcoming = "/movie/upcoming"
    }
    
    // MARK: Private variables
    
    private let apiKey: String = "1f54bd990f1cdfb230adb312546d765d"
    
    // MARK: Internal methods
    func getGenres() -> Single<[Genre]> {
        
        let url = TMDBApi.baseUrl + Endpoint.getGenres
        
        return Single.create(subscribe: { (event) -> Disposable in
            guard let url = URL(string: url) else {
                event(.error(Error.generic))
                return Disposables.create()
            }
            
            let request = Alamofire.request(url, method: .get, parameters: ["api_key": self.apiKey], encoding: URLEncoding.queryString, headers: [:])
            
            request.responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let object):
                    guard
                          let dict = object as? [String: Any],
                          let items = dict["genres"],
                          let data = try? JSONSerialization.data(withJSONObject: items, options: .prettyPrinted)
                    else { return }
                        
                    let decoder = JSONDecoder()
                    let genres = try! decoder.decode([Genre].self, from: data)
                    print(genres)
                
                case .failure(let error):
                    break
                }
            })
            return Disposables.create {
                request.cancel()
            }
        })
    }
    
    // MARK: Internal methods
    func getUpcoming() -> Single<[Movie]> {
        
        let url = TMDBApi.baseUrl + Endpoint.getUpcoming
        
        return Single.create(subscribe: { (event) -> Disposable in
            guard let url = URL(string: url) else {
                event(.error(Error.generic))
                return Disposables.create()
            }
            
            let request = Alamofire.request(url, method: .get, parameters: ["api_key": self.apiKey], encoding: URLEncoding.queryString, headers: [:])
            
            request.responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let object):
                    guard
                        let dict = object as? [String: Any],
                        let items = dict["results"] as? [[String: Any]],
                        let data = try? JSONSerialization.data(withJSONObject: items, options: .prettyPrinted)
                    else { return }
                    
                    let decoder = JSONDecoder()
                    let movies = try? decoder.decode([Movie].self, from: data)
                    event(.success(movies ?? []))
                    
                case .failure(let error):
                    break
                }
            })
            return Disposables.create {
                request.cancel()
            }
        })
    }
}

// MARK: Static variables
extension TMDBApi {
    
    static let baseUrl: String = "https://api.themoviedb.org/3"
    static let imageBaseUrl: String = "https://image.tmdb.org/t/p/w500"
}
