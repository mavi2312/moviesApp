//
//  MovieTableViewCell.swift
//  MoviesApp
//
//  Created by Lol on 4/4/18.
//  Copyright © 2018 mavzapps. All rights reserved.
//

import UIKit
import SDWebImage

class MovieTableViewCell: UITableViewCell {

    @IBOutlet private weak var cardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.layer.borderColor = UIColor.lightGray.cgColor
        cardView.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setMovie(_ movie:Movie){
        titleLabel.text = movie.title
        ratingLabel.text = "\(movie.vote_average)"
        let stringPoster = "http://image.tmdb.org/t/p/w500"+movie.poster_path
        let urlPoster = URL(string:stringPoster)
        activityIndicatorView.startAnimating()
        posterImageView.sd_setImage(with: urlPoster) { [unowned self] (image, _, _, _) in
            self.activityIndicatorView.stopAnimating()
        }
    }
}
