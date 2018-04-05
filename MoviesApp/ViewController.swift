//
//  ViewController.swift
//  MoviesApp
//
//  Created by Lol on 4/4/18.
//  Copyright © 2018 mavzapps. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var movieTableView: UITableView!
    
    @IBOutlet weak var orderTypeSegmentedControl: UISegmentedControl!
    
    enum orderType:String {
        case popular = "https://api.themoviedb.org/3/movie/popular?api_key=34738023d27013e6d1b995443764da44"
        case topRated = "https://api.themoviedb.org/3/movie/top_rated?api_key=34738023d27013e6d1b995443764da44"
    }
    
    let reuseIdentifier = "MovieCell"
    
    var popularMovies = [Movie]()
    var topRatedMovies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Clean empty cells
        movieTableView.tableFooterView = UIView()
        movieTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        //Get PopularMovies
        getMovies(by: .popular)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        self.movieTableView.reloadData()
        getMovies(by: sender.selectedSegmentIndex == 0 ? .popular:.topRated)
    }
    
    func getMovies(by type: orderType){
        
        guard let url = URL(string: type.rawValue) else {
            return
        }
        
        URLSession.shared.dataTask(with: url){ [unowned self] (data,response,error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else {return}
            
            do{
                guard let response = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any], let results = response["results"]  else {return}
                let jsonData = try JSONSerialization.data(withJSONObject: results, options: .prettyPrinted)
                let movies = try JSONDecoder().decode([Movie].self, from: jsonData)
                
                switch type {
                    case .popular:
                        self.popularMovies = movies
                    case .topRated:
                        self.topRatedMovies = movies
                }
                
                DispatchQueue.main.async { () -> Void in
                    self.movieTableView.reloadData()
                }
            } catch let jsonError {
                print(jsonError)
            }
            
        }.resume()
    }
    
    //MARK: - UITableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderTypeSegmentedControl.selectedSegmentIndex == 0 ? popularMovies.count : topRatedMovies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MovieTableViewCell
        cell.setMovie(orderTypeSegmentedControl.selectedSegmentIndex == 0 ? popularMovies[indexPath.row] : topRatedMovies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetail = MovieDetailView()
        movieDetail.setMovie(orderTypeSegmentedControl.selectedSegmentIndex == 0 ? popularMovies[indexPath.row] : topRatedMovies[indexPath.row])
        movieDetail.show(animated: true)
    }
}

