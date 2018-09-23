//
//  MovileDetailsViewController.swift
//  TMDB App
//
//  Created by Luciano Bohrer on 23/09/18.
//  Copyright © 2018 Luciano Bohrer. All rights reserved.
//

import UIKit
import Nuke

// MARK: - Class
class MovileDetailsViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    
    // MARK: Internal variables
    var movie: Movie!
    
    // MARK: Overridden methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.titleLabel.text = movie.title
        self.releaseLabel.text = movie.formattedData
        self.genreLabel.text = Genre.genresNames(ids: movie.genre_ids).first.map({ $0.name })
        self.overviewTextView.text = movie.overview
        
        if let url = URL(string: TMDBApi.imageBaseUrl + (movie.poster_path ?? "")) {
            Nuke.loadImage(with: url,
                           options: ImageLoadingOptions(placeholder: UIImage(named: "placeholder-image"),
                                                        transition: .fadeIn(duration: 0.33)),
                           into: self.coverImage)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
    }

}
