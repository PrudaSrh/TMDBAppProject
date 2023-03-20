//
//  ViewController.swift
//  theMovieDBAppProject
//
//  Created by Serhii on 1/14/23.
//

import UIKit
import SDWebImage
import YoutubePlayer_in_WKWebView



class MovieDetailViewController: UIViewController {
    static var stateSegment: MediaType = .movie
    var movieDetailViewModel: MovieDetailViewModel?
    
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var contentUIView: UIView!
    @IBOutlet weak var originalTitle: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var youTubeView: WKYTPlayerView!
    @IBOutlet weak var addToFavoriteButton: UIButton!
    
    // MARK: - Cell Identifier
    static let identifier = "MovieDetailViewController"
    
//    var isFavoriteMovie: Bool = false {
//        didSet {
//            if isFavoriteMovie {
//                addToFavoriteButton.setImage(UIImage(named:  "saved"), for: .normal)
//                movieDetailViewModel?.saveMovieToRealm(movie: movieDetailViewModel?.movie)
//            } else {
//                addToFavoriteButton.setImage(UIImage(named:  "save"), for: .normal)
//                movieDetailViewModel?.deleteMovie(movie: movieDetailViewModel?.movie)
//            }
//        }
//    }
    
    var isFavorite: Bool = false {
        didSet {
            if isFavorite {
                addToFavoriteButton.setImage(UIImage(named: "saved"), for: .normal)
                if let movie = movieDetailViewModel?.movie {
                    movieDetailViewModel?.saveMovieToRealm(movie: movie)
                } else if let tvShow = movieDetailViewModel?.tv {
                    movieDetailViewModel?.saveTVShowToRealm(tvShow: tvShow)
                }
            } else {
                addToFavoriteButton.setImage(UIImage(named: "save"), for: .normal)
                if let movie = movieDetailViewModel?.movie {
                    movieDetailViewModel?.deleteMovie(movie: movie)
                } else if let tvShow = movieDetailViewModel?.tv {
                    movieDetailViewModel?.deleteTVShow(tvShow: tvShow)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchTrailerTVShow()
        fetchTrailerMovie()
        fetchTrailerMedia()
        setupUIMowie()
        setupUITVShow()
        setupUIMedia()
    }
    
    // MARK: - YouTube configure
    
    // MARK: тут спробував переписати функциї fetchTrailerTVShow() fetchTrailerMovie() fetchTrailerMedia() тут в створив окрему колекцію trailers и передав дані пошуку

//    func fetchTrailerTVShow() {
//        movieDetailViewModel?.getTrailerTVShow { [weak self] results in
//            let sorted = results.filter { video in
//                return video.type == "Trailer"
//            }
//            for video in sorted {
//                self?.movieDetailViewModel?.videosPath.append(video.key ?? "")
//            }
//        }
////        DispatchQueue.main.async {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.youTubeView.load(withVideoId: self.movieDetailViewModel?.videosPath[0] ?? "")
//        }
//    }
    
//    func fetchTrailerMovie() {
//        movieDetailViewModel?.getTrailerMovie { [weak self] results in
//            let sorted = results.filter { video in
//                return video.type == "Trailer"
//            }
//            for video in sorted {
//                self?.movieDetailViewModel?.videosPath.append(video.key ?? "")
//            }
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.youTubeView.load(withVideoId: self.movieDetailViewModel?.videosPath[0] ?? "")
//        }
//    }
    
//    func fetchTrailerMedia() {
//        movieDetailViewModel?.getTrailerMedia { [weak self] results in
//            let sorted = results.filter { video in
//                return video.type == "Trailer"
//            }
//            for video in sorted {
//                self?.movieDetailViewModel?.videosPath.append(video.key ?? "")
//            }
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.youTubeView.load(withVideoId: self.movieDetailViewModel?.videosPath[0] ?? "")
//        }
//    }
    
    func fetchTrailerTVShow() {
        movieDetailViewModel?.getTrailerTVShow { [weak self] results in
            let trailers = results.filter { $0.type == "Trailer" }
            self?.movieDetailViewModel?.videosPath = trailers.compactMap { $0.key }
            if let videoId = self?.movieDetailViewModel?.videosPath.first {
                DispatchQueue.main.async {
                    self?.youTubeView.load(withVideoId: videoId)
                }
            }
        }
    }
    
    func fetchTrailerMovie() {
        movieDetailViewModel?.getTrailerMovie { [weak self] results in
            let trailers = results.filter { $0.type == "Trailer" }
            self?.movieDetailViewModel?.videosPath = trailers.compactMap { $0.key }
            if let videoId = self?.movieDetailViewModel?.videosPath.first {
                DispatchQueue.main.async {
                    self?.youTubeView.load(withVideoId: videoId)
                }
            }
        }
    }

    func fetchTrailerMedia() {
        movieDetailViewModel?.getTrailerMedia { [weak self] results in
            let trailers = results.filter { $0.type == "Trailer" }
            self?.movieDetailViewModel?.videosPath = trailers.compactMap { $0.key }
            if let videoId = self?.movieDetailViewModel?.videosPath.first {
                DispatchQueue.main.async {
                    self?.youTubeView.load(withVideoId: videoId)
                }
            }
        }
    }
    
    @IBAction func addToFavoriteButtonPressed(_ sender: Any) {
        isFavorite = !isFavorite
        toggleFavoriteButtonColor()
    }
    func toggleFavoriteButtonColor() {
        if addToFavoriteButton.layer.borderColor == UIColor.gray.cgColor {
            addToFavoriteButton.layer.borderColor = UIColor.yellow.cgColor
        } else {
            addToFavoriteButton.layer.borderColor = UIColor.gray.cgColor
        }
    }
    
    private func setupUIMedia() {
        if let movieDetailViewModel = movieDetailViewModel, let media = movieDetailViewModel.media {
            loadingView.startAnimating()
            self.titleImageView.sd_setImage(with: URL(string: (APIs.getImage.rawValue + media.posterPath)), completed: nil)
            self.originalTitle.text = media.originalTitle != nil && media.originalTitle != "" ? media.originalTitle : media.originalName
            
            self.loadingView.stopAnimating()
            titleImageView.layer.cornerRadius = 20
            
            self.overview.text = media.overview
            if let voteAverage = movieDetailViewModel.media?.voteAverage {
                self.ratingLabel.text = String(format: "%.1f",voteAverage)
            }
        }
        
        // MARK: - Configure favoriteButton
        addToFavoriteButton.layer.cornerRadius = 6
        addToFavoriteButton.layer.borderWidth = 1
        addToFavoriteButton.layer.borderColor = UIColor.gray.cgColor
        ratingStackView.layer.cornerRadius = 10
    }
    
    private func setupUIMowie() {
        if let movieDetailViewModel = movieDetailViewModel, let movie = movieDetailViewModel.movie {
            loadingView.startAnimating()
            self.titleImageView.sd_setImage(with: URL(string: (APIs.getImage.rawValue + (movie.posterPath ?? ""))), completed: nil)
            self.originalTitle.text = movie.originalTitle
            self.loadingView.stopAnimating()
            titleImageView.layer.cornerRadius = 20
            
            self.overview.text = movie.overview
            if let voteAverage = movieDetailViewModel.movie?.voteAverage {
                self.ratingLabel.text = String(format: "%.1f",voteAverage)
            }
        }
        
        // MARK: - Configure favoriteButton
        addToFavoriteButton.layer.cornerRadius = 6
        addToFavoriteButton.layer.borderWidth = 1
        addToFavoriteButton.layer.borderColor = UIColor.gray.cgColor
        ratingStackView.layer.cornerRadius = 10
    }
    
    private func setupUITVShow() {
        if let movieDetailViewModel = movieDetailViewModel, let tvShow = movieDetailViewModel.tv {
            loadingView.startAnimating()
            self.titleImageView.sd_setImage(with: URL(string: (APIs.getImage.rawValue + (tvShow.posterPath ?? ""))), completed: nil)
            self.originalTitle.text = tvShow.originalName
            self.loadingView.stopAnimating()
            contentUIView.layer.cornerRadius = 20
            titleImageView.layer.cornerRadius = 20
            
            self.overview.text = tvShow.overview
            if let voteAverage = movieDetailViewModel.tv?.voteAverage {
                self.ratingLabel.text = String(format: "%.1f",voteAverage)
            }
        }
        ratingStackView.layer.cornerRadius = 5
    }
}

