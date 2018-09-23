//
//  UpcomingListViewModel.swift
//  TMDB App
//
//  Created by Luciano Bohrer on 23/09/18.
//  Copyright © 2018 Luciano Bohrer. All rights reserved.
//

import RxSwift

// MARK: - Class
final class UpcomingListViewModel {

    //MARK: Outputs
    var items = Observable<[Movie]>.of([])
    
    // MARK: Private variables
    private var services: TMDBApi = TMDBApi()
    private var page: Int = 0
    private var source: [Movie] = []
    
    // MARK: Initializers
    init(nextPage: Observable<Void>) {
        items = nextPage
            .flatMapLatest({ (_) -> Observable<[Movie]> in
                return self.services.getUpcoming(page: self.page + 1).asObservable()
            }).map({ items in
                self.source + items
            })
            .do(onNext: { self.source = $0; self.page += 1 })
    }
}
