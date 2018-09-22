//
//  UpcomingTableViewCell.swift
//  TMDB App
//
//  Created by Luciano Bohrer on 22/09/18.
//  Copyright © 2018 Luciano Bohrer. All rights reserved.
//

import UIKit

// MARK: - Class
final class UpcomingTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var containerCell: UIView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
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
}
