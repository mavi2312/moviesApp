//
//  Movie.swift
//  MoviesApp
//
//  Created by Lol on 4/4/18.
//  Copyright © 2018 mavzapps. All rights reserved.
//

import UIKit

class Movie: Codable {
    
    let title:String
    let poster_path:String
    let overview:String
    let release_date:String
    let vote_average:Float
    let backdrop_path:String
}
