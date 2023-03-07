//
//  MoviesViewController.swift
//  theMovieDBAppProject
//
//  Created by Serhii on 1/21/23.

import UIKit
import Alamofire
import SDWebImage

class TrendingMovieViewController: UIViewController {
    var moviesViewModel = TrendingMediaViewModel()
    var movieDetailViewModel: MovieDetailViewModel?
    
    @IBOutlet weak var typeSegmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Register cell
        let nib = UINib(nibName: "TrendingTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "TrendingTableViewCell")
        
        fetchMovies ()
        fetchTVShows ()
    }
    
    @IBAction func typeSegmentControlTapped(_ sender: Any) {
        tableView.setContentOffset(.zero, animated: false)
        tableView.reloadData()
        
        //        let selectedMediaType: MediaType = (typeSegmentControl.selectedSegmentIndex == 0) ? .movie : .tv
    }
}

// MARK: - Configure the tableView
extension TrendingMovieViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.moviesViewModel.arrayOfMovies.count
        switch typeSegmentControl.selectedSegmentIndex {
        case 0:
            TrendingMediaViewModel.stateSegment = .movie
            self.moviesViewModel.arrayOfMovies.count
            
        case 1:
            TrendingMediaViewModel.stateSegment = .tv
            return moviesViewModel.arrayOfMovies.count
            
        default:
            fatalError("segment controll error")
        }
        return moviesViewModel.arrayOfMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell") as! TrendingTableViewCell
        switch typeSegmentControl.selectedSegmentIndex {
        case 0:
            cell.configure(with: moviesViewModel.arrayOfMovies[indexPath.row])
            
        case 1:
            cell.configure(with: moviesViewModel.arrayOfTVShows[indexPath.row])
            
        default:
            fatalError("segment controll error")
        }
        return cell
    }
}

extension  TrendingMovieViewController {
    func  fetchMovies () {
        let requestMovies =  AF .request( APIs.getTrendingMovies.rawValue )
        requestMovies.responseDecodable(of: TrandingMovies.self) { listOfMovies in
            self.moviesViewModel.arrayOfMovies = listOfMovies.value?.results ?? []
            self.tableView.reloadData()
        }
    }
    
    func  fetchTVShows () {
        let requestMovies =  AF .request( APIs.getTrendingTVs.rawValue )
        requestMovies.responseDecodable(of: TrandingTVShows.self) { listOfTVShows in
            self.moviesViewModel.arrayOfTVShows = listOfTVShows.value?.results ?? []
            self.tableView.reloadData()
        }
    }
}

// MARK: - Push to detail screen
extension TrendingMovieViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        let mediaData = moviesViewModel.arrayOfMovies[indexPath.row]
        let tvShowsData = moviesViewModel.arrayOfTVShows[indexPath.row]
        switch typeSegmentControl.selectedSegmentIndex {
        case 0:
            viewController.movieDetailViewModel = MovieDetailViewModel(movie: mediaData)
        case 1:
            viewController.movieDetailViewModel = MovieDetailViewModel(tv: tvShowsData)
            
        default:
            fatalError("segment controll error")
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
}


