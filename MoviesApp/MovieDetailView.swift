//
//  MovieDetailView.swift
//  MoviesApp
//
//  Created by Lol on 4/5/18.
//  Copyright © 2018 mavzapps. All rights reserved.
//

import UIKit

class MovieDetailView: UIView, Modal {
    
    var backgroundView = UIView()
    
    var dialogView = UIView()
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    convenience init(){
        self.init(frame: UIScreen.main.bounds)
        loadMovieView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadMovieView(){
        backgroundView.frame = frame
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.6
    
        addSubview(backgroundView)
        addConstraintsToBackground()
        
        Bundle.main.loadNibNamed("MovieDetailView", owner: self, options: nil)
        dialogView = contentView
        addSubview(dialogView)
        dialogView.frame.origin = CGPoint(x: 32, y: frame.height)
        dialogView.frame.size = CGSize(width: frame.width - 30, height: contentView.frame.height)
        dialogView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        addConstraintsToDialog()
        
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self,action: #selector(didTapOnBackgroundView)))
        
    }
    
    func addConstraintsToBackground(){
        backgroundView.translatesAutoresizingMaskIntoConstraints = false;
        let centerX = NSLayoutConstraint(item: backgroundView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: backgroundView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: backgroundView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0)
        let height = NSLayoutConstraint(item: backgroundView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        addConstraints([centerX, centerY, width, height])
    }
    
    func addConstraintsToDialog(){
        dialogView.translatesAutoresizingMaskIntoConstraints = false;
        
        let centerX = NSLayoutConstraint(item: dialogView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: dialogView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: dialogView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.width, multiplier: 0.8, constant: 0)
        let height = NSLayoutConstraint(item: dialogView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.height, multiplier: 0.8, constant: 0)
        addConstraints([centerX, centerY, width, height])
    }
    
    func setMovie(_ movie:Movie){
        titleLabel.text = movie.title
        ratingLabel.text = "\(movie.vote_average)"
        overviewLabel.text = movie.overview
        releaseDateLabel.text = movie.release_date
        let stringBackdrop = "http://image.tmdb.org/t/p/w500"+movie.backdrop_path
        let urlBackdrop = URL(string:stringBackdrop)
        activityIndicatorView.startAnimating()
        backdropImageView.sd_setImage(with: urlBackdrop) { [unowned self] (image, _, _, _) in
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    @objc func didTapOnBackgroundView(){
        dismiss(animated: true)
    }
    

}
