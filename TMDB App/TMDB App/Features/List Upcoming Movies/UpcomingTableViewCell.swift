//
//  UpcomingTableViewCell.swift
//  TMDB App
//
//  Created by Luciano Bohrer on 22/09/18.
//  Copyright © 2018 Luciano Bohrer. All rights reserved.
//

import UIKit
import Nuke

// MARK: - Class
final class UpcomingTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet private weak var coverImage: UIImageView!
    @IBOutlet private weak var containerCell: UIView!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    
    // MARK: Overridden methods
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    
    // MARK: Private methods
    private func setupView() {
        self.backgroundColor = UIColor.clear
        self.coverImage.layer.cornerRadius = 6
        self.containerCell.backgroundColor = UIColor.white
        self.containerCell.layer.cornerRadius = 6
        self.containerCell.clipsToBounds = true
    }
    
    // MARK: Internal methods
    func configure(movie: Movie) {
        if let url = URL(string: TMDBApi.imageBaseUrl + (movie.poster_path ?? "")) {
            Nuke.loadImage(with: url,
                           options: ImageLoadingOptions(placeholder: UIImage(named: "placeholder-image"),
                                                        transition: .fadeIn(duration: 0.33)),
                           into: self.coverImage)
        }
        
        self.nameLabel.text = movie.title
    }
}
