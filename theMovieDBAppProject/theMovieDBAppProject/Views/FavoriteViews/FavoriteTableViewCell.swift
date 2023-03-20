//
//  FavoriteTableViewCell.swift
//  theMovieDBAppProject
//
//  Created by Serhii on 3/4/23.
//

import UIKit
import SDWebImage

protocol FavoriteTableViewCellDelegate: AnyObject {
//    func saveMovie(movie: Movie)
//    func saveTVShow(tvShow: TVShows)
    func tableViewMovieCellDelegate(movie: MovieRealm)
    
}
class FavoriteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var contentUIView: UIView!
    @IBOutlet weak var originalTitle: UILabel!
    
    weak var delegate: FavoriteTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        titleImageView.image = nil
    }
    
    // MARK: - Public methods
    
    func configureWith(movie: MovieRealm) {
        loadingView.startAnimating()
        self.titleImageView.sd_setImage(with: URL(string: (APIs.getImage.rawValue + (movie.posterPath ?? "https://picsum.photos/200"))),
                                        completed: { [weak self] _, _, _, _ in
            guard let self = self else { return }
            self.loadingView.stopAnimating()
            self.ratingLabel.text = String(format: "%.1f", movie.voteAverage)
            self.originalTitle.text = movie.originalTitle
        })
    }
    func configureWith(tvShow: TVRealm) {
        loadingView.startAnimating()
        self.titleImageView.sd_setImage(with: URL(string: (APIs.getImage.rawValue + (tvShow.posterPath ?? "https://picsum.photos/200"))),
                                        completed: { [weak self] _, _, _, _ in
            guard let self = self else { return }
            self.loadingView.stopAnimating()
            self.ratingLabel.text = String(format: "%.1f", tvShow.voteAverage)
            self.originalTitle.text = tvShow.originalName
        })
    }
    func configureWith(media: TVRealm) {
        loadingView.startAnimating()
        self.titleImageView.sd_setImage(with: URL(string: (APIs.getImage.rawValue + (media.posterPath ?? "https://picsum.photos/200"))),
                                        completed: { [weak self] _, _, _, _ in
            guard let self = self else { return }
            self.loadingView.stopAnimating()
            self.ratingLabel.text = String(format: "%.1f", media.voteAverage)
            self.originalTitle.text = media.originalName
        })
    }
}
