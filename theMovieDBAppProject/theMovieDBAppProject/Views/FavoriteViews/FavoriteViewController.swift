//
//  FavoriteViewController.swift
//  theMovieDBAppProject
//
//  Created by Serhii on 3/4/23.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    var moviesViewModel = TrendingMediaViewModel()
    var arrayOfMovies: [Movie] = []
    var viewModel: FavoriteViewModel = FavoriteViewModel()
    
    @IBOutlet weak var favoriteTableView: UITableView!
    @IBOutlet weak var favoriteTypeSegmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "WATCH LIST"

        let nib = UINib(nibName: "FavoriteTableViewCell", bundle: nil)
        self.favoriteTableView.register(nib, forCellReuseIdentifier: "FavoriteTableViewCell")
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getMovie()
        viewModel.getTVShow()
        self.favoriteTableView.reloadData()
        favoriteTableView.setContentOffset(.zero, animated: true)
    }
    
}

extension FavoriteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch favoriteTypeSegmentControl.selectedSegmentIndex {
        case 0:
            TrendingMediaViewModel.stateSegment = .movie
            self.viewModel.movies.count

        case 1:
            TrendingMediaViewModel.stateSegment = .tv
            return viewModel.tvShows.count

        default:
            fatalError("segment controll error")
        }
        return viewModel.movies.count
        
//        if !viewModel.media.isEmpty {
//            switch favoriteTypeSegmentControl.selectedSegmentIndex {
//            case 0:
//                return viewModel.movies.count
//            case 1:
//                return viewModel.tvShows.count
//            default:
//                fatalError("Invalid segment index")
//            }
//        } else {
//            switch favoriteTypeSegmentControl.selectedSegmentIndex {
//            case 0:
//                return moviesViewModel.arrayOfMovies.count
//            case 1:
//                return moviesViewModel.arrayOfTVShows.count
//            default:
//                fatalError("Invalid segment index")
//            }
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell") as! FavoriteTableViewCell
        switch favoriteTypeSegmentControl.selectedSegmentIndex {
        case 0:
            cell.configureWith(movie: viewModel.movies[indexPath.row])
            
        case 1:
            cell.configureWith(tvShow: viewModel.tvShows[indexPath.row])
            
        default:
            fatalError("segment controll error")
        }
        return cell
    }
}
// MARK: FavoriteTableViewCellDelegate

//extension FavoriteViewController: FavoriteTableViewCellDelegate {
//
//    func tableViewMovieCellDelegate(movie: MovieRealm) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        guard let viewController = storyboard.instantiateViewController(withIdentifier: MovieDetailViewController.identifier) as? MovieDetailViewController else { return }
//        let movie = Movie(
//            id: movie.id,
//            originalTitle: movie.originalTitle,
//            overview: movie.overview,
//            voteAverage: movie.voteAverage,
//            posterPath: movie.posterPath)
//        viewController.viewModel.movie = movie
////            id: movie.id,
////            original_name: movie.originalTitle,
////            original_title: movie.originalTitle,
////            overview: movie.overview,
////            poster_path: movie.posterPath,
////            vote_count: movie.voteCount,
////            release_date: movie.firstAirDate ?? movie.releaseDate,
////            vote_average: movie.voteAverage, first_air_date: movie.firstAirDate)
//        navigationController?.pushViewController(viewController, animated: true)
//    }
//}

// testCom
